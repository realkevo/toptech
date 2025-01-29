/*import 'package:flutter/material.dart';
import 'package:toptech/databaseservice/databaseservice.dart';
class Servicestate extends StatelessWidget {
  const Servicestate({super.key});

  @override
  Widget build(BuildContext context) {
    final Databaseservice databaseservice = Databaseservice();
return Container(
  height: 400,

  color: Colors.white12,
  child: Column(

    children: <Widget> [
      Text("services", style:
      TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),),

      //todo insert the services cardviews here

    ],
  ),
);
  }
}*/


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ServiceList extends StatelessWidget {
  const ServiceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Reference to Firestore collection
    final servicesCollection = FirebaseFirestore.instance.collection('services');

    return
      StreamBuilder<QuerySnapshot>(
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

          return ListView.builder(
            itemCount: serviceList.length,
            itemBuilder: (context, index) {
              final service = serviceList[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.service_title ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.service_description ?? 'No Description',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price (Ksh): ${service.service_priceKsh ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Price (USD): ${service.service_priceUsd ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
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