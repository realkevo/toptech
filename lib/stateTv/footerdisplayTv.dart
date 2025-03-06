
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For image byte manipulation

class FooterDisplayTv extends StatefulWidget {
  @override
  _FooterDisplayTvState createState() => _FooterDisplayTvState();
}

class _FooterDisplayTvState extends State<FooterDisplayTv> {
  // Method to fetch data from Firestore
  Future<Map<String, String>> fetchFooterData() async {
    try {
      // Get the first document from the 'footerData' collection
      var querySnapshot =
      await FirebaseFirestore.instance.collection('footerData').get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming the first document contains the data
        var document = querySnapshot.docs[0];

        // Retrieve the base64-encoded strings
        return {
          'githubIcon': document['githubIcon'],
          'xIcon': document['xIcon'],
          'redditIcon': document['redditIcon'],
          'facebookIcon': document['facebookIcon'],
          'partnerOneIcon': document['partnerOneIcon'],
          'partnerTwoIcon': document['partnerTwoIcon'],
          'partnerThreeIcon': document['partnerThreeIcon'],
          'copyRightIcon': document['copyRightIcon'],
        };
      } else {
        return {};
      }
    } catch (e) {
      print("Error fetching footer data: $e");
      return {};
    }
  }

  // Method to decode base64 and convert to Image widget
  Image _decodeBase64ToImage(String base64String) {
    try {
      Uint8List bytes = base64Decode(base64String);
      return Image.memory(bytes);
    } catch (e) {
      print("Error decoding base64: $e");
      return Image.asset('assets/placeholder.png'); // Use a placeholder in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 70,
        width: MediaQuery.sizeOf(context).width * 1,
        child: FutureBuilder<Map<String, String>>(
          future: fetchFooterData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error loading data"));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No data available"));
            }

            var footerData = snapshot.data!;

            return Container(
              color: Colors.orange,
              child:
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                    children: [
                    //Social Link Row
                    Container(
                      color: Colors.black,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 30,
                            child: footerData['githubIcon'] != null
                                ? _decodeBase64ToImage(footerData['githubIcon']!)
                                : Text("No image"),
                          ),
                          Container(
                            height: 30,
                            child: footerData['xIcon'] != null
                                ? _decodeBase64ToImage(footerData['xIcon']!)
                                : Text("No image"),
                          ),
                          Container(
                            height: 30,
                            child: footerData['redditIcon'] != null
                                ? _decodeBase64ToImage(footerData['redditIcon']!)
                                : Text("No image"),
                          ),
                          Container(
                            height: 30,
                            child: footerData['facebookIcon'] != null
                                ? _decodeBase64ToImage(footerData['facebookIcon']!)
                                : Text("No image"),
                          ),

                        ],
                      ),
                    ),
                    Container(
                width: MediaQuery.sizeOf(context).width *1,
                      height: 1,
                      color: Colors.white,
                    ),
                    //Partners Container

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 30,
                            child: footerData['copyRightIcon'] != null
                                ? _decodeBase64ToImage(footerData['copyRightIcon']!)
                                : Text("No image"),
                          ),

                          Container(
                            width: 200,
                            color: Colors.orange,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("FAQ"),
                                Text("Terms of Service"),


                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("our sponsors and partners"),
                              Container(
                                height: 30,
                                color: Colors.orange,
                                child: Row(
                                  spacing: 10,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      child: footerData['partnerOneIcon'] != null
                                          ? _decodeBase64ToImage(footerData['partnerOneIcon']!)
                                          : Text("No image"),
                                    ),
                                    SizedBox(width: 5,),

                                    Container(
                                      height: 30,
                                      child: footerData['partnerTwoIcon']
                                          != null
                                          ? _decodeBase64ToImage(footerData[
                                            'partnerTwoIcon']!)
                                          : Text("No image"),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      height: 30,
                                      child: footerData['partnerThreeIcon']
                                          != null
                                          ? _decodeBase64ToImage(footerData[
                                      'partnerThreeIcon']!)
                                          : Text("No image"),
                                    ),


                                  ],
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),

                  ],),
              ),
            );
          },
        ),
      );
  }
}
