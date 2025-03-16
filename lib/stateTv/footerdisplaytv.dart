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
    double heightFactor = MediaQuery.of(context).size.height;
    double widthFactor = MediaQuery.of(context).size.width;

    return Container(
      width: widthFactor,
      padding: EdgeInsets.symmetric(horizontal: widthFactor * 0.05, vertical: heightFactor * 0.012), // Further reduced vertical padding
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7.0),
          topRight: Radius.circular(7.0),
        ),
      ),
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

          return
            Container(
              child:
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                children: [
                  // Row for main content
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Column - Socials
                      Flexible(
                        flex: 2,
                        child:
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown, // Ensure text scales down to fit
                                child: Text(
                                  "Follow us",
                                  style: TextStyle(
                                    fontSize: heightFactor * 0.014, // Further reduced responsive font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              footerData['githubIcon'] != null
                                  ? Row(
                                spacing: 12,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    height: 14, // Further reduced height
                                    child: _decodeBase64ToImage(footerData['githubIcon']!),
                                  ),
                                  Text(
                                    "github",
                                    style: TextStyle(
                                      fontSize: heightFactor * 0.014, // Responsive font size
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                                  : SizedBox.shrink(),
                              footerData['xIcon'] != null
                                  ? Row(
                                spacing: 12,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    height: 14, // Further reduced height
                                    child: _decodeBase64ToImage(footerData['xIcon']!),
                                  ),
                                  Text(
                                    "X",
                                    style: TextStyle(
                                      fontSize: heightFactor * 0.014, // Responsive font size
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                                  : SizedBox.shrink(),
                              footerData['redditIcon'] != null
                                  ? Row(
                                spacing: 12,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    height: 14, // Further reduced height
                                    child: _decodeBase64ToImage(footerData['redditIcon']!),
                                  ),
                                  Text(
                                    "reddit",
                                    style: TextStyle(
                                      fontSize: heightFactor * 0.014, // Responsive font size
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                                  : SizedBox.shrink(),
                              footerData['facebookIcon'] != null
                                  ? Row(
                                spacing: 12,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    height: 14, // Further reduced height
                                    child: _decodeBase64ToImage(footerData['facebookIcon']!),
                                  ),
                                  Text(
                                    "linkedin",
                                    style: TextStyle(
                                      fontSize: heightFactor * 0.014, // Responsive font size
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                
                      // Center Column - PO Box and Address
                      Flexible(
                        flex: 3,
                        child:
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "P.O Box 600-63 Nairobi, Kenya",
                                style: TextStyle(
                                  fontSize: heightFactor * 0.014, // Further reduced responsive font size
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Mombasa Road, Platnum Plaza flr 2",
                                style: TextStyle(
                                  fontSize: heightFactor * 0.014, // Further reduced responsive font size
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                
                      // Right Column - Partners
                      Flexible(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.0),
                              topRight: Radius.circular(7.0),
                            ),
                            color: Colors.deepOrange,

                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown, // Ensure text scales down to fit
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                                  child: Text(
                                    "Partners and sponsors",
                                    style: TextStyle(
                                      fontSize: heightFactor * 0.024, // Further reduced responsive font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        footerData['partnerOneIcon'] != null
                                            ? Container(
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                          height: 20, // Further reduced height
                                          child: _decodeBase64ToImage(footerData['partnerOneIcon']!),
                                        )
                                            : SizedBox.shrink(),
                                        footerData['partnerTwoIcon'] != null
                                            ? Container(
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                          height: 20, // Further reduced height
                                          child: _decodeBase64ToImage(footerData['partnerTwoIcon']!),
                                        )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        footerData['partnerThreeIcon'] != null
                                            ? Container(
                                          height: 20, // Further reduced height
                                          child: _decodeBase64ToImage(footerData['partnerThreeIcon']!),
                                        )
                                            : SizedBox.shrink(),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                
                  // Bottom row for copyright
                  Container(
                    color: Colors.blueAccent,
                    width: widthFactor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        footerData['copyRightIcon'] != null
                            ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 20, // Further reduced height
                          child: _decodeBase64ToImage(footerData['copyRightIcon']!),
                        )
                            : SizedBox.shrink(),
                        Text(
                          "Copyright",
                          style: TextStyle(
                            fontSize: heightFactor * 0.024, // Further reduced responsive font size
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                          ),
              ),
            );
        },
      ),
    );
  }
}