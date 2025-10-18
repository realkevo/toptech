import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toptech/stateTv/teamdisplay.dart';

import 'footerdisplaytv.dart';
import 'remarkDisplay.dart';

class Homepagedisplay extends StatefulWidget {
  const Homepagedisplay({super.key});

  @override
  State<Homepagedisplay> createState() => _HomepagedisplayState();
}

class _HomepagedisplayState extends State<Homepagedisplay>
    with TickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _allServices = [];
  int _currentBatchStartIndex = 0;
  final int _batchSize = 3;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Track hover state per card
  final Set<int> _hoveredIndexes = {};

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    _fetchServices();
  }

  Future<void> _fetchServices() async {
    final snapshot = await _firestore.collection('servicesData').get();
    setState(() {
      _allServices = snapshot.docs.map((doc) => doc.data()).toList();
      _currentBatchStartIndex = 0;
    });
    _fadeController.forward();
  }

  void _loadMore() async {
    if (_allServices.isEmpty) return;

    await _fadeController.reverse();

    setState(() {
      _currentBatchStartIndex += _batchSize;

      if (_currentBatchStartIndex >= _allServices.length) {
        _currentBatchStartIndex = 0;
      }
    });

    await _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int endIndex = (_currentBatchStartIndex + _batchSize) <= _allServices.length
        ? (_currentBatchStartIndex + _batchSize)
        : _allServices.length;
    final List<Map<String, dynamic>> visibleServices =
    _allServices.isEmpty ? [] : _allServices.sublist(_currentBatchStartIndex, endIndex);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0A0E21),
            Color(0xFF12233F),
            Color(0xFF1E3C72),
          ],
        ),
      ),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "SERVICES",
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedBuilder(
                    animation: _fadeController,
                    builder: (context, child) {
                      return Column(
                        spacing: 20,
                        children: List.generate(visibleServices.length, (index) {
                          final service = visibleServices[index];
                          final isHovered = _hoveredIndexes.contains(index);

                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Opacity(
                              opacity: _fadeAnimation.value,
                              child: MouseRegion(
                                onEnter: (_) {
                                  setState(() => _hoveredIndexes.add(index));
                                },
                                onExit: (_) {
                                  setState(() => _hoveredIndexes.remove(index));
                                },
                                child: TweenAnimationBuilder<double>(
                                  duration: const Duration(milliseconds: 500),
                                  curve: isHovered ? Curves.bounceOut : Curves.easeOut,
                                  tween: Tween<double>(
                                      begin: 1.0,
                                      end: isHovered ? 1.25 : 1.0),
                                  builder: (context, scale, child) {
                                    return Transform.scale(
                                      scale: scale,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFF0A0E21),
                                                Color(0xFF1E3C72),
                                              ],
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                service['serviceTitle'] ?? 'No Title',
                                                style: const TextStyle(
                                                  color: Colors.lightGreen,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 8),

                                              // Full width thick white divider
                                              const Divider(
                                                color: Colors.white,
                                                thickness: 2,
                                                height: 20, // space before & after divider
                                              ),

                                              Text(
                                                service['serviceDescription'] ?? 'No Description',
                                                style: const TextStyle(color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                      onPressed: _loadMore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                      ),
                      child: const Text('Load More'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const RemarkDisplayClass(),
                  const SizedBox(height: 20),
                  const TeamDisplay(),
                  const FooterDisplayTv(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
