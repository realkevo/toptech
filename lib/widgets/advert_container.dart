import 'package:flutter/material.dart';

class AdvertContainer extends StatefulWidget {
  const AdvertContainer({super.key});

  @override
  _AdvertContainerState createState() => _AdvertContainerState();
}

class _AdvertContainerState extends State<AdvertContainer> with SingleTickerProviderStateMixin {
  bool _isTapped = false; // Variable to track tap state
  late AnimationController _animationController; // Animation controller for the flip
  late Animation<double> _rotationAnimation; // Rotation animation for flip

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with a duration
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this, // This will use the current state as the ticker provider
    );

    // Create the rotation animation (from 0.0 to 1.0 to simulate a 360-degree flip)
    _rotationAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 38.0, bottom: 20),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isTapped = !_isTapped; // Toggle the tapped state
              });

              // Trigger the flip animation by calling forward on the controller
              if (_isTapped) {
                _animationController.forward(); // Start the flip
              } else {
                _animationController.reverse(); // Reverse the flip (reset)
              }
            },
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                // Use RotationTransition to apply the flip effect
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(_rotationAnimation.value * 3.14159), // 3.14159 = Pi (180 degrees)
                  child: AnimatedContainer(
                    height: _isTapped ? 400 : 350, // Change height on tap
                    width: _isTapped ? 330 : 300, // Change width on tap
                    duration: const Duration(milliseconds: 500), // Animation duration
                    curve: Curves.easeInOut, // Smooth curve for animation
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.blue.shade900],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        // You can add additional widgets inside here as needed
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
