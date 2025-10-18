/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'footerdisplaytv.dart';
import 'remarkDisplay.dart';

class ServiceDisplayClass extends StatefulWidget {
  const ServiceDisplayClass({super.key});

  @override
  _ServiceDisplayClassState createState() => _ServiceDisplayClassState();
}

class _ServiceDisplayClassState extends State<ServiceDisplayClass>
    with TickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _allServices = [];
  int _visibleCount = 3;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    _fetchServices();
  }

  Future<void> _fetchServices() async {
    final snapshot = await _firestore.collection('servicesData').get();
    setState(() {
      _allServices = snapshot.docs.map((doc) => doc.data()).toList();
    });
    _fadeController.forward();
  }

  void _loadMore() async {
    if (_visibleCount >= _allServices.length) return;
    await _fadeController.reverse();
    setState(() {
      _visibleCount += 3;
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
    final List<Map<String, dynamic>> visibleServices =
    _allServices.take(_visibleCount).toList();

    return Column(
      children: [
        AnimatedBuilder(
          animation: _fadeController,
          builder: (context, child) {
            return Column(
              children: visibleServices
                  .map(
                    (service) => Opacity(
                  opacity: _fadeAnimation.value,
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
                          Text(
                            service['serviceDescription'] ?? 'No Description',
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            );
          },
        ),

        const SizedBox(height: 10),

        if (_visibleCount < _allServices.length)
          ElevatedButton(
            onPressed: _loadMore,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen,
            ),
            child: const Text('Load More'),
          ),

        const SizedBox(height: 20),

        // Keeping RemarkDisplay and Footer isolated
        const RemarkDisplayClass(),

        const SizedBox(height: 20),

        // Memoize or make footer constant if possible
        const FooterDisplayTv(),
      ],
    );
  }
}
*/