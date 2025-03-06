
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

class HeaderDisplayClass extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<List<HeaderData>>(
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

          height: 85,
            decoration: BoxDecoration(
            color: Colors.blueAccent, // Set the background color
            borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0), // Adjust the radius as needed
        bottomRight: Radius.circular(20.0), // Adjust the radius as needed
            ),),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: headerDataList.map((headerData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (headerData.bannerIcon.isNotEmpty)
                    Image.network(headerData.bannerIcon),
                  if (headerData.siteTitle.isNotEmpty)
                    Text(headerData.siteTitle,
                        style: TextStyle(fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  if (headerData.slogan.isNotEmpty)
                    Text(headerData.slogan,
                        style: TextStyle(fontSize: 16)),
                  Row(
                    children: [

                      IconButton(onPressed: (){},
                          icon: Icon(Icons.menu_sharp)),


                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [

                                ],),
                                IconButton(onPressed: (){},
                                    icon: Icon(Icons.location_on)),

                                if (headerData.locationText.isNotEmpty)
                                  Text(headerData.locationText
                                    ,
                                    style: TextStyle(fontSize: 10),
                                  ),

                                IconButton(onPressed: (){},
                                    icon: Icon(Icons.phone)),

                                if (headerData.phoneText.isNotEmpty)
                                  Text('Phone: ${headerData.phoneText}',
                                  style: TextStyle(fontSize: 10),
                                  ),
                                IconButton(onPressed: (){},
                                    icon: Icon(Icons.email)),

                                if (headerData.email.isNotEmpty)
                                  Text('Email: ${headerData.email}',
                                    style: TextStyle(fontSize: 10),
                                  ),



                              ],
                            ),
                          ),
                        ),
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