import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Reference to Firestore collection
    final servicesCollection = FirebaseFirestore.instance.collection('services');

    return StreamBuilder<QuerySnapshot>(
      stream: servicesCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //todo implement custom loading bar from github
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No services found.'));
        }

        final serviceList = snapshot.data!.docs.map((doc) {
          return Databaseservice.fromDocument(doc);
        }).toList();

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
            crossAxisSpacing: 10, // Horizontal spacing between items
            mainAxisSpacing: 10, // Vertical spacing between items
            childAspectRatio: 0.8, // Adjust item size (width/height ratio)
          ),
          itemCount: serviceList.length,
          itemBuilder: (context, index) {
            final service = serviceList[index];

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.deepPurple,
                //  boxShadow: [
                //    BoxShadow(
                //      color: Colors.blue.withOpacity(0.5),
                //      blurRadius: 30,
                //      spreadRadius: 10,
                //      offset: Offset(4, 8),
                //    ),
                //  ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    service.service_title ?? 'No Title',
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
                          boxShadow: [],
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                            //  overflow: TextOverflow.ellipsis,
                              service.service_description ?? 'No Description',
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
                  // Prices row for services
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
                        'ksh: ${service.service_priceKsh ?? 'N/A'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'usd: ${service.service_priceUsd ?? 'N/A'}',
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
          },
        );
      },
    );
  }
}

// Databaseservice class remains unchanged
class Databaseservice {
  String? service_title;
  String? service_description;
  String? service_priceKsh;
  String? service_priceUsd;

  Databaseservice({
    this.service_title,
    this.service_description,
    this.service_priceKsh,
    this.service_priceUsd,
  });

  Map<String, dynamic> toMap() {
    return {
      'service_title': service_title,
      'service_description': service_description,
      'service_priceKsh': service_priceKsh,
      'service_priceUsd': service_priceUsd,
    };
  }

  factory Databaseservice.fromDocument(DocumentSnapshot doc) {
    return Databaseservice(
      service_title: doc['service_title'],
      service_description: doc['service_description'],
      service_priceKsh: doc['service_priceKsh'],
      service_priceUsd: doc['service_priceUsd'],
    );
  }
}
