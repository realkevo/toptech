import 'package:flutter/material.dart';
import 'dart:async';
import '../stateTv/desktophomepagedisplay.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    Timer.periodic(Duration(milliseconds: 250), (timer) {
      setState(() {
        if (_progress < 1.0) {
          _progress += 0.1; // Increase progress
        } else {
          timer.cancel();
          _navigateToHome();
        }
      });
    });
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepagedisplay()), // Change to your homepage widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for hacker theme
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flutter_dash, // Example Flutter icon
              size: 100,
              color: Colors.greenAccent, // Hacker-like color
            ),
            SizedBox(height: 20),
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 24,
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildHackerProgressBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHackerProgressBar() {
    return Container(
      width: 300,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[800],
      ),
      child: Stack(
        children: [
          Container(
            width: _progress * 300, // Width based on progress
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.greenAccent,
            ),
          ),
          Center(
            child: Text(
              "${(_progress * 100).toInt()}%",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}