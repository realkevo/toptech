import 'dart:convert';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class WelcomeDrawerData {
  final String? welcomeImageBase64;
  final String? welcomeMessage;

  WelcomeDrawerData({
    this.welcomeImageBase64,
    this.welcomeMessage,
  });

  factory WelcomeDrawerData.fromFirestore(Map<String, dynamic> map) {
    return WelcomeDrawerData(
      welcomeImageBase64: map['welcomeImageBase64'],
      welcomeMessage: map['welcomeMessage'],
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  WelcomeDrawerData? _data;
  bool _hasConnection = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (mounted) {
        setState(() => _hasConnection = false);
      }
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('welcome_drawer_data')
          .orderBy('welcomeMessage', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty && mounted) {
        setState(() {
          _data = WelcomeDrawerData.fromFirestore(snapshot.docs.first.data());
        });
      }
    } catch (e) {
      // Handle or log the error if needed
      debugPrint("Error loading splash data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: const Duration(seconds: 4),
      nextScreen: const MyApp(), // Navigates to your main app
      backgroundColor: Colors.white,
      splashScreenBody: _buildSplashContent(),
    );
  }

  Widget _buildSplashContent() {
    if (!_hasConnection) {
      return const Center(
        child: Text(
          "You're offline",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      );
    }

    if (_data == null) {
      // You can show a loading indicator or just a blank screen
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_data!.welcomeImageBase64 != null)
          Image.memory(base64Decode(_data!.welcomeImageBase64!), height: 200),
        const SizedBox(height: 20),
        if (_data!.welcomeMessage != null)
          Text(
            _data!.welcomeMessage!,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
