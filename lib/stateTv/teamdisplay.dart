import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamDisplay extends StatefulWidget {
  const TeamDisplay({super.key});

  @override
  _TeamDisplayState createState() => _TeamDisplayState();
}

class _TeamDisplayState extends State<TeamDisplay> {
  final PageController _pageController = PageController(viewportFraction: 1);
  List<DocumentSnapshot> _teams = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 4));
      if (_teams.isEmpty || !_pageController.hasClients) continue;

      _currentPage++;
      if (_currentPage >= _teams.length) {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final double size = MediaQuery.of(context).size.width * 0.87; // fixed square size
    final double padding = 2.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30), // Reduced vertical padding
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('teamData').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text(''));
              }

              // Data is loaded, update _teams list
              _teams = snapshot.data!.docs;

              // Now that the data is loaded, show the title and the content
              return Column(
                children: [
                  const Text(
                    "OUR TEAM",
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: size,
                    height: 250,
                    padding: EdgeInsets.all(padding),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _teams.length,
                      itemBuilder: (context, index) {
                        final member = _teams[index];
                        final name = member['MemberName'] ?? '';
                        final specialty = member['MemberSpecialty'] ?? '';
                        final experience = member['MemberExperience'] ?? '';

                        return _ZoomableCard(
                          name: name,
                          specialty: specialty,
                          experience: experience,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ZoomableCard extends StatefulWidget {
  final String name;
  final String specialty;
  final String experience;

  const _ZoomableCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.experience,
  }) : super(key: key);

  @override
  State<_ZoomableCard> createState() => _ZoomableCardState();
}

class _ZoomableCardState extends State<_ZoomableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _hovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _onEnter(bool hover) {
    setState(() {
      _hovering = hover;
      if (hover) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _onTapDown(_) {
    _controller.forward();
  }

  void _onTapUp(_) {
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: child,
            );
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.specialty,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.experience,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
