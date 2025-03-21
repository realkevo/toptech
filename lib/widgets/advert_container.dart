import 'package:flutter/material.dart';

class AdvertContainer extends StatefulWidget {
  const AdvertContainer({super.key});

  @override
  _AdvertContainerState createState() => _AdvertContainerState();
}

class _AdvertContainerState extends State<AdvertContainer> {
  bool _isTapped = false; // Variable to track tap state

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0, bottom: 20),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isTapped = !_isTapped; // Toggle the tapped state
          });
        },
        child: AnimatedContainer(
          height: _isTapped ? 450 : 400, // Change height on tap
          width: _isTapped ? 375 : 350, // Change width on tap
          duration: const Duration(milliseconds: 300), // Animation duration
          curve: Curves.easeInOut, // Smooth curve for animation
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.green.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
