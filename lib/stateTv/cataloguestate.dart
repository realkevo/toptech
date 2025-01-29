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



class CatalogueList extends StatelessWidget {
  const CatalogueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Reference to Firestore collection
    final servicesCollection = FirebaseFirestore.instance.collection('cataloguedata');

    return
      StreamBuilder<QuerySnapshot>(
        stream: servicesCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No catalogues found.'));
          }

          final catalogueList = snapshot.data!.docs.map((doc) {
            return DatabaseCatalogue.fromDocument(doc);
          }).toList();

          return ListView.builder(
            itemCount: catalogueList.length,
            itemBuilder: (context, index) {
              final cataloguedata = catalogueList[index];

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
                child: Row(
                  children: [
                    Container(height: 70,
                    width: 70,
                    color: Colors.white,
                    child: Text("cataloguedata image"),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cataloguedata.catalogue_title ?? 'No Title',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cataloguedata.catalogue_description ?? 'No Description',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
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
class DatabaseCatalogue {
  String? catalogue_title;
  String? catalogue_description;
  //todo add toggle button dark mode/light
  //todo add drawer button



  DatabaseCatalogue({this.catalogue_title, this.catalogue_description});

  Map<String, dynamic> toMap() {
    return {
      'catalogue_title': catalogue_title,

      'catalogue_description': catalogue_description,
    };
  }

  // Create a User object from a document snapshot
  factory DatabaseCatalogue.fromDocument(DocumentSnapshot doc) {
    return DatabaseCatalogue(
      catalogue_title: doc['catalogue_title'],
      catalogue_description: doc['catalogue_description'],


    );
  }
}
