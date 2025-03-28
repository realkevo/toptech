import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceDisplayClass extends StatefulWidget {
  @override
  _ServiceDisplayClassState createState() => _ServiceDisplayClassState();
}

class _ServiceDisplayClassState extends State<ServiceDisplayClass> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch the services from Firestore
  Stream<List<Map<String, dynamic>>> fetchServices() {
    return _firestore.collection('servicesData').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }

  int? _tappedIndex; // Track the tapped index
  bool _isShaking = false; // Track if the card is shaking

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive font size based on screen width
    double titleFontSize =
        screenWidth * 0.04; // Title font size is 5% of screen width
    double descriptionFontSize =
        screenWidth * 0.035; // Description font size is 3.5% of screen width
    double priceFontSize =
        screenWidth * 0.04; // Price font size is 4% of screen width
    double inquireFontSize =
        screenWidth * 0.035; // Inquire button font size is 3.5% of screen width

    return Container(
      width: screenWidth * 0.99,
      height: screenHeight * 0.60, // Height is 40% of the screen height
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: fetchServices(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No services available'));
          }

          var services = snapshot.data!;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
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
            Padding(
              padding: EdgeInsets.all(
                  screenWidth * 0.02,
              ), // Padding is 2% of screen width
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 600
                      ? 3
                      : 2, // Use 2 columns for large screens, 1 for small
                  crossAxisSpacing: screenWidth * 0.02, // Space between columns
                  mainAxisSpacing: screenWidth * 0.02, // Space between rows
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  var serviceData = services[index];
                  bool isTapped =
                      _tappedIndex == index; // Check if this card is tapped

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_tappedIndex == index) {
                          _isShaking = !_isShaking; // Toggle the shaking effect
                        } else {
                          _tappedIndex = index; // Set new tapped index
                          _isShaking = true; // Start shaking
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(
                          milliseconds: 300
                      ), // Duration for the animation
                      curve: Curves.easeInOut,
                      transform: Matrix4.translationValues(
                          isTapped && _isShaking
                              ? 10.0 * (index % 2 == 0 ? 1 : -1)
                              : 0.0,
                          0.0,
                          0.0), // Apply shake effect
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: isTapped
                              ? [
                                  Colors.black, // Black gradient when tapped
                                  Colors.black54,
                                ]
                              : [
                                  Color(0xFF0A0E21), // Dark blue
                                  Color(0xFF12233F), // Slightly lighter blue
                                  Color(0xFF1E3C72), // Mid blue
                                ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      width: screenWidth * 0.35, // Set card size
                      height: screenHeight * 0.2, // Set card height
                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child:
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit
                                  .scaleDown, // Ensure text scales down to fit
                              child: Text(
                                serviceData['serviceTitle'] ?? 'No Title',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      16, // Font size adjusts relative to screen size
                                  fontWeight: FontWeight.bold,
                                  decoration:
                                      TextDecoration.none, // No underline
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth *
                                    0.01), // Padding based on screen width
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.03),
                                    child: Text(
                                      serviceData['serviceDescription'] ??
                                          'No Description',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            12, // Font size adjusts relative to screen size
                                        fontWeight: FontWeight.normal,
                                        decoration:
                                            TextDecoration.none, // No underline
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 7.0, right: 7.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          12, // Font size adjusts relative to screen size
                                      fontWeight: FontWeight.normal,
                                      decoration:
                                          TextDecoration.none, // No underline
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    'Ksh:   ${serviceData['servicePriceKsh'] ?? 'N/A'}',
                                    style: TextStyle(
                                      color: Colors.orange[200],
                                      fontSize:
                                          12, // Font size adjusts relative to screen size
                                      fontWeight: FontWeight.bold,
                                      decoration:
                                          TextDecoration.none, // No underline
                                    ),
                                  ),
                                  Text(
                                    'USD:   ${serviceData['servicePriceUsd'] ?? 'N/A'}',
                                    style: TextStyle(
                                      color: Colors.orange[200],
                                      fontSize:
                                          12, // Font size adjusts relative to screen size
                                      fontWeight: FontWeight.bold,
                                      decoration:
                                          TextDecoration.none, // No underline
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
