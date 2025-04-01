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
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('adContainer')
            .snapshots(),
        builder: (context, snapshot) {
         /* if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
*/
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final dataList = snapshot.data!.docs.map((doc) {
            return SloganDataPojo.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: dataList.map((SloganDataPojo uploadData) {
                Uint8List decodedIcon = base64Decode(uploadData.toptechIcon);
                return
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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

                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Display image
                        Image.memory(
                          decodedIcon,
                          height: 300, // Set height as needed
                          width: double.infinity, // Set width to match the container
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        // Display slogan
                        Text(
                          uploadData.toptechSlogan,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,

                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
              }).toList(),
            ),
          );
        },
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
