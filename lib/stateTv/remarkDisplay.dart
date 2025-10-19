import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RemarkDisplayClass extends StatefulWidget {
  const RemarkDisplayClass({super.key});

  @override
  _RemarkDisplayClassState createState() => _RemarkDisplayClassState();
}

class _RemarkDisplayClassState extends State<RemarkDisplayClass> {
  List<DocumentSnapshot> _remarks = [];
  int _currentIndex = 0;
  bool _isPointerDown = false;
  bool _isLoading = true; // Flag to control loading state

  @override
  void initState() {
    super.initState();
    _fetchRemarks();  // Fetch data on init
    _startAutoplay();
  }

  void _startAutoplay() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 5));
      if (!_isPointerDown && _remarks.isNotEmpty) {
        _changeRemark((_currentIndex + 1) % _remarks.length);
      }
    }
  }

  void _fetchRemarks() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('remarkData').get();
      setState(() {
        _remarks = snapshot.docs;
        _isLoading = false; // Stop loading once data is fetched
      });
    } catch (e) {
      // Handle any errors, you can show an error message here if needed
      print("Error fetching remarks: $e");
      setState(() {
        _isLoading = false; // Stop loading even on error to avoid infinite spinner
      });
    }
  }

  void _changeRemark(int newIndex) {
    if (_remarks.isEmpty) return;
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20, top: 40),
      child: Column(
        children: [
          // Only show "REVIEWS" title when the data is fetched and loaded
          if (!_isLoading)
            const Text(
              "REVIEWS",
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 20),

          // Show loading indicator only when data is still loading


          if (!_isLoading)
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('remarkData').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text(''));
                }

                var currentRemark = _remarks[_currentIndex];
                var name = currentRemark['remarkName'] ?? 'Anonymous';
                var description = currentRemark['remarkDescription']
                    ?? '';
                var date = currentRemark['remarkDate'] ?? '';

                return GestureDetector(
                  onTapDown: (_) => setState(() => _isPointerDown = true),
                  onTapUp: (_) => setState(() => _isPointerDown = false),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // LEFT ARROW
                      IconButton(
                        icon: const Icon(Icons.arrow_left, color: Colors.white),
                        iconSize: 40,
                        onPressed: () {
                          int newIndex =
                              (_currentIndex - 1 + _remarks.length) % _remarks.length;
                          _changeRemark(newIndex);
                        },
                      ),

                      // CIRCULAR CONTAINER with AnimatedSwitcher
                      ClipOval(
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF0A0E21),
                                Color(0xFF1E3C72),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder: (Widget child, Animation<double> animation) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                              child: SingleChildScrollView(
                                key: ValueKey<int>(_currentIndex),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 200,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        description,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        date,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // RIGHT ARROW
                      IconButton(
                        icon: const Icon(Icons.arrow_right, color: Colors.white),
                        iconSize: 40,
                        onPressed: () {
                          int newIndex = (_currentIndex + 1) % _remarks.length;
                          _changeRemark(newIndex);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
