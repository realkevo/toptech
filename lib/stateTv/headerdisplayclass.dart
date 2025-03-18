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

class HeaderDisplay extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: headerDataList.map((headerData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (headerData.bannerIcon.isNotEmpty)
                    Image.network(headerData.bannerIcon),
                  if (headerData.siteTitle.isNotEmpty)
                    Text(
                      headerData.siteTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (headerData.slogan.isNotEmpty)
                    Text(
                      headerData.slogan,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(

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

                    width: MediaQuery.of(context).size.width * 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left Container (Location)
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(

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
                                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      color: Colors.white,
                                      icon: Icon(Icons.menu_sharp),
                                      iconSize: MediaQuery.of(context).size.width * 0.07, // Responsive Icon Size
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.location_on),
                                      iconSize: MediaQuery
                                          .of(context).size.width * 0.03, // Responsive Icon Size
                                      color: Colors.white,
                                    ),
                                    if (headerData.locationText.isNotEmpty)
                                      Flexible(
                                        child: Text(

                                          headerData.locationText,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                            MediaQuery.of(context).
                                            size.width * 0.02,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Right Container (Contact Information)
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(

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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.phone),
                                    color: Colors.white,
                                    iconSize: MediaQuery
                                        .of(context).size.width * 0.03, // Responsive Icon Size
                                  ),
                                  if (headerData.phoneText.isNotEmpty)
                                    Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown, // Ensure text scales down to fit
                                        child:
                                        Text(
                                          headerData.phoneText,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.
                                            of(context).size.width * 0.02,
                                            decoration: TextDecoration.none, // No underline
                                      
                                          ),
                                        ),
                                      
                                      ),
                                    ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.email),
                                    iconSize: MediaQuery
                                        .of(context).size.width * 0.03, // Responsive Icon Size
                                    color: Colors.white,
                                  ),
                                  if (headerData.email.isNotEmpty)
                                    Flexible(
                                      child:
                                      FittedBox(
                                        fit: BoxFit.scaleDown, // Ensure text scales down to fit
                                        child:                                       Text(
                                          headerData.email,
                                          style:
                                          TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                            MediaQuery.of(context).size
                                                .width * 0.06,
                                            decoration: TextDecoration.none, // No underline

                                          ),
                                        ),


                                      ),



                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
