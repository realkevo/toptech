import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceDisplayClass extends StatefulWidget {
  @override
  _ServiceDisplayClassState createState() => _ServiceDisplayClassState();
}

class _ServiceDisplayClassState extends State<ServiceDisplayClass> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController _scrollController = ScrollController();

  Stream<List<Map<String, dynamic>>> fetchServices() {
    return _firestore.collection('servicesData').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      alignment: Alignment.center,
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
            width: MediaQuery.sizeOf(context).width * 0.9,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              // Border removed here
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A0E21),
                  Color(0xFF1E3C72),
                ],
              ),
            ),
            child: ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (context, index) {
                var serviceData = services[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.lightGreenAccent,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0A0E21),
                          Color(0xFF1E3C72),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
