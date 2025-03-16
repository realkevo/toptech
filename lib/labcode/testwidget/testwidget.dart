import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HeaderData {
  String bannerIcon;
  String siteTitle;
  String slogan;
  String phoneText;
  String email;
  String locationText;

  HeaderData({
    required this.bannerIcon,
    required this.siteTitle,
    required this.slogan,
    required this.phoneText,
    required this.email,
    required this.locationText,
  });

  // Convert HeaderData to a Map
  Map<String, dynamic> toMap() {
    return {
      'bannerIcon': bannerIcon,
      'siteTitle': siteTitle,
      'slogan': slogan,
      'phoneText': phoneText,
      'email': email,
      'locationText': locationText,
    };
  }

  // Convert a Map to HeaderData
  factory HeaderData.fromMap(Map<String, dynamic> map) {
    return HeaderData(
      bannerIcon: map['bannerIcon'] ?? '',
      siteTitle: map['siteTitle'] ?? '',
      slogan: map['slogan'] ?? '',
      phoneText: map['phoneText'] ?? '',
      email: map['email'] ?? '',
      locationText: map['locationText'] ?? '',
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<HeaderData>> fetchHeaderData() {
    return _db.collection('headerData').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return HeaderData.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}

class HeadTest extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<List<HeaderData>>(
      stream: _firestoreService.fetchHeaderData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final headerDataList = snapshot.data!;

        return Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7.0),
              bottomRight: Radius.circular(7.0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: headerDataList.map((headerData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (headerData.bannerIcon.isNotEmpty)
                    Image.network(
                      headerData.bannerIcon,
                      width: screenWidth * 0.8, // Responsive width
                    ),
                  if (headerData.siteTitle.isNotEmpty)
                    Text(
                      headerData.siteTitle,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (headerData.slogan.isNotEmpty)
                    Text(
                      headerData.slogan,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035, // Responsive font size
                      ),
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.menu_sharp),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.location_on),
                            iconSize: screenWidth * 0.04, // Responsive icon size
                            color: Colors.black,
                          ),
                          if (headerData.locationText.isNotEmpty)
                            Text(
                              headerData.locationText,
                              style: TextStyle(
                                fontSize: screenWidth * 0.025, // Responsive font size
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.phone),
                            color: Colors.black,
                            iconSize: screenWidth * 0.04, // Responsive icon size
                          ),
                          if (headerData.phoneText.isNotEmpty)
                            Text(
                              headerData.phoneText,
                              style: TextStyle(
                                fontSize: screenWidth * 0.025, // Responsive font size
                              ),
                            ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.email),
                            iconSize: screenWidth * 0.04, // Responsive icon size
                            color: Colors.black,
                          ),
                          if (headerData.email.isNotEmpty)
                            Text(
                              headerData.email,
                              style: TextStyle(
                                fontSize: screenWidth * 0.025, // Responsive font size
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}