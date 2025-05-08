import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceDisplayClass extends StatefulWidget {
  @override
  _ServiceDisplayClassState createState() => _ServiceDisplayClassState();
}

class _ServiceDisplayClassState extends State<ServiceDisplayClass> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> fetchServices() {
    return _firestore.collection('servicesData').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        width: screenWidth * 0.99,
        height: screenHeight * 0.60,
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
                    Color(0xFF0A0E21),
                    Color(0xFF12233F),
                    Color(0xFF1E3C72),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    var serviceData = services[index];

                    return Center(
                      child: SizedBox(
                        width: screenWidth * 0.48,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF0A0E21),
                                Color(0xFF12233F),
                                Color(0xFF1E3C72),
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
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceData['serviceTitle'] ?? 'No Title',
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                serviceData['serviceDescription'] ?? 'No Description',
                                style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}
