/*import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../screens/serviceupload.dart';
import '../screens/welcome_and_drawer_upload.dart';
import '../stateTv/homepage_displayTv.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

import '../screens/welcome_and_drawer_upload.dart';
import '../main.dart'; // Import MyApp

class HomeSplash extends StatelessWidget {
  const HomeSplash({super.key});

  Future<WelcomeDrawerDataUpload?> _fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('welcome_drawer_data')
        .orderBy('welcomeMessage', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return WelcomeDrawerDataUpload.fromFirestore(snapshot.docs.first.data());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: const Duration(seconds: 4), // Customize delay here
      nextScreen: MyApp(),            // Auto-navigate here
      backgroundColor: Colors.white,
      splashScreenBody: FutureBuilder<WelcomeDrawerDataUpload?>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No splash data found"));
          }

          final data = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (data.welcomeImageBase64 != null)
                Image.memory(base64Decode(data.welcomeImageBase64!), height: 200),
              const SizedBox(height: 20),
              if (data.welcomeMessage != null)
                Text(data.welcomeMessage!,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          );
        },
      ),
    );
  }
}
*/