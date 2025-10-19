import 'dart:convert';
import 'dart:math'; // Import for pi
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SloganDisplayWidget extends StatefulWidget {
  const SloganDisplayWidget({super.key});

  @override
  State<SloganDisplayWidget> createState() => _SloganDisplayWidgetState();
}

class _SloganDisplayWidgetState extends State<SloganDisplayWidget>
    with SingleTickerProviderStateMixin {
  // Controller for the looping spin animation
  late final AnimationController _spinController;

  // State variable to track the zoom state
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  // Helper methods to change the zoom state
  void _zoomIn() {
    if (mounted) setState(() => _isZoomed = true);
  }

  void _zoomOut() {
    if (mounted) setState(() => _isZoomed = false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('adContainer').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text(''));
        }

        final dataList = snapshot.data!.docs.map((doc) {
          return SloganDataPojo.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: dataList.map((SloganDataPojo uploadData) {
            Uint8List decodedIcon;
            try {
              decodedIcon = base64Decode(uploadData.toptechIcon);
            } catch (e) {
              // Return a card with an error message for this item
              return Card(
                color: Colors.red[100],
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Invalid image format in data.'),
                ),
              );
            }

            // Use TweenAnimationBuilder to animate the scale of the whole card
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1.0, end: _isZoomed ? 1.1 : 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              // The child is our interactive card
              child: GestureDetector(
                onTapDown: (_) => _zoomIn(),
                onTapUp: (_) => _zoomOut(),
                onTapCancel: () => _zoomOut(),
                child: MouseRegion(
                  onEnter: (_) => _zoomIn(),
                  onExit: (_) => _zoomOut(),
                  // CORE CHANGE: The decoration property has been removed to make it transparent.
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    margin: const EdgeInsets.only(bottom: 16),
                    // The 'decoration' property has been removed from here.
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // The animated image part remains the same
                        AnimatedBuilder(
                          animation: _spinController,
                          builder: (context, child) {
                            final angle = _spinController.value * 2 * pi;
                            final isFlipped = _spinController.value > 0.5;

                            return Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001) // Perspective
                                ..rotateY(angle),      // Spin
                              alignment: Alignment.center,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..rotateY(isFlipped ? pi : 0),
                                alignment: Alignment.center,
                                child: child,
                              ),
                            );
                          },
                          child: ClipRRect( // Added ClipRRect to ensure the image corners are rounded
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.memory(
                              decodedIcon,
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.broken_image,
                                        color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // The text part remains the same
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          child: Text(
                            uploadData.toptechSlogan,
                            style: const TextStyle(
                              color: Colors.white, // You might want to adjust text color for visibility
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// SloganDataPojo class remains the same
class SloganDataPojo {
  String toptechIcon;
  String toptechSlogan;

  SloganDataPojo({
    required this.toptechIcon,
    required this.toptechSlogan,
  });

  Map<String, dynamic> toMap() {
    return {
      'toptechIcon': toptechIcon,
      'toptechSlogan': toptechSlogan,
    };
  }

  factory SloganDataPojo.fromMap(Map<String, dynamic> map) {
    return SloganDataPojo(
      toptechIcon: map['toptechIcon'] ?? '',
      toptechSlogan: map['toptechSlogan'] ?? '',
    );
  }
}
