import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../databaseservice/databaseservice.dart';

class ServicePage extends StatelessWidget {
  // Fetch services from Firestore
  Future<List<Databaseservice>> fetchServices() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('services').get();
    return snapshot.docs.map((doc) => Databaseservice.fromDocument(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return

      FutureBuilder<List<Databaseservice>>(
        future: fetchServices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No services available.'));
          }

          List<Databaseservice> services = snapshot.data!;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,  // Number of columns
              crossAxisSpacing: 8,  // Horizontal spacing between grid items
              mainAxisSpacing: 8,  // Vertical spacing between grid items
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return _buildServiceItem(services[index]);
            },
          );
        },
      );
  }

  Widget _buildServiceItem(Databaseservice serviceData) {
    return Container(
      height: 300,
      width: 400,
      color: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            serviceData.service_title ?? 'No Title',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      serviceData.service_description ?? 'No Description',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "price",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'ksh: ${serviceData.service_priceKsh ?? 'N/A'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'usd: ${serviceData.service_priceUsd ?? 'N/A'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                color: Colors.orange,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "INQUIRE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
