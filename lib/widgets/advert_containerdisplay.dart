import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SloganDisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child:
      Container(
        height: 500,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0E21), // Dark blue
              Color(0xFF12233F), // Slightly lighter blue
              Color(0xFF1E3C72), // Mid blue
            ],
          ),


        ),

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('adContainer')
                .snapshots(),
            builder: (context, snapshot) {
              // Handling different states of connection
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No data available'));
              }

              final dataList = snapshot.data!.docs.map((doc) {
                return SloganDataPojo.fromMap(doc.data() as Map<String, dynamic>);
              }).toList();

              return Column(
                children: dataList.map(( SloganDataPojo uploadData) {
                  // Decode the base64 image
                  Uint8List decodedIcon = base64Decode(uploadData.toptechIcon);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        spacing: 20,
                        children: [
                          // Display image
                          Image.memory(
                            decodedIcon,
                            height: 300,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          // Display slogan
                          Text(
                            uploadData.toptechSlogan,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SloganDataPojo {
  String toptechIcon;
  String toptechSlogan;

  SloganDataPojo({
    required this.toptechIcon,
    required this.toptechSlogan,
  });

  // Convert UploadData to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'toptechIcon': toptechIcon,
      'toptechSlogan': toptechSlogan,
    };
  }

  // Convert a Map to UploadData (for fetching from Firestore)
  factory SloganDataPojo.fromMap(Map<String, dynamic> map) {
    return SloganDataPojo(
      toptechIcon: map['toptechIcon'] ?? '',
      toptechSlogan: map['toptechSlogan'] ?? '',
    );
  }
}
