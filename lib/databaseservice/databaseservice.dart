import 'package:flutter/material.dart';
import'package:cloud_firestore/cloud_firestore.dart';
/*class DatabaseService {
  final FirebaseFirestore _firebase =
      FirebaseFirestore.instance;

  Future<void> addData(String service_title, String service_description, String
  service_priceKsh, String service_priceUsd) async {
    try {
      await _firebase.collection('toptechdata').add({
      });
    }

    catch (e) {
      print(e.toString());
    }
  }
}*/
import 'package:cloud_firestore/cloud_firestore.dart';

class Databaseservice {
  String? service_title;
      String? service_description;
  String? service_priceKsh;
      String? service_priceUsd;

  Databaseservice({this.service_title, this.service_description, this.service_priceKsh,
  this.service_priceUsd});

  Map<String, dynamic> toMap() {
    return {
      'service_title': service_title,

      'service_description': service_description,
      'service_priceKsh': service_priceKsh,
      'service_priceUsd' : service_priceUsd,
    };
  }

  // Create a User object from a document snapshot
  factory Databaseservice.fromDocument(DocumentSnapshot doc) {
    return Databaseservice(
      service_title: doc['service_title'],
      service_description: doc['service_description'],
      service_priceKsh: doc['service_priceKsh'],
      service_priceUsd: doc['service_priceUsd'],


    );
  }
}

// ... in your main function or wherever you want to upload data
Future<void> uploadUserData(Databaseservice databaseservice) async {
  // Get a reference to the Firestore collection
  final CollectionReference servicesCollection =
  FirebaseFirestore.instance.collection('services');

  // Upload the user data to Firestore
  try {
    await servicesCollection.doc(databaseservice.service_title).set(databaseservice.toMap());
    print('User data uploaded successfully!');
  } catch (e) {
    print('Error uploading user data: $e');
  }
}


class DatabaseContact {
  //contatc variables
  String? contact_name;
  String? contact_email;
  String? contact_phone;

  DatabaseContact({this.contact_name, this.contact_email, this.contact_phone,});

  Map<String, dynamic> toMap() {
    return {
      'contact_name': contact_name,

      'contact_email': contact_email,
      'contact_phone': contact_phone,
    };
  }

  // Create a User object from a document snapshot
  factory DatabaseContact.fromDocument(DocumentSnapshot doc) {
    return DatabaseContact(
      contact_name: doc['contact_name'],
      contact_email: doc['contact_email'],
      contact_phone: doc['contact_phone'],


    );
  }
}


// ... in your main function or wherever you want to upload data
Future<void> uploadContactData(DatabaseContact databasecontact) async {
  // Get a reference to the Firestore collection
  final CollectionReference contatcollection =
  FirebaseFirestore.instance.collection('contacts');

  // Upload the user data to Firestore
  try {
    await contatcollection.doc(databasecontact.contact_phone).set(databasecontact.toMap());
    print('User data uploaded successfully!');
  } catch (e) {
    print('Error uploading user data: $e');
  }
}


class DatabaseHeader {
  String? header_title;
  String? header_slogan;
  //todo add toggle button dark mode/light
  //todo add drawer button



  DatabaseHeader({this.header_title, this.header_slogan});

  Map<String, dynamic> toMap() {
    return {
      'header_title': header_title,

      'header_slogan': header_slogan,
    };
  }

  // Create a User object from a document snapshot
  factory DatabaseHeader.fromDocument(DocumentSnapshot doc) {
    return DatabaseHeader(
      header_title: doc['header_title'],
      header_slogan: doc['header_slogan'],


    );
  }
}

// ... in your main function or wherever you want to upload data
Future<void> uploadHeaderData(DatabaseHeader databaseheader) async {
  // Get a reference to the Firestore collection
  final CollectionReference headercollection =
  FirebaseFirestore.instance.collection('headerdata');

  // Upload the user data to Firestore
  try {
    await headercollection.doc(databaseheader.header_title).set(databaseheader.toMap());
    print('header data uploaded successfuly!');
  } catch (e) {
    print('Error uploading header data: $e');
  }
}


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

// ... in your main function or wherever you want to upload data
Future<void> uploadCatalogue(DatabaseCatalogue databasecatalogue) async {
  // Get a reference to the Firestore collection
  final CollectionReference cataloguecollection =
  FirebaseFirestore.instance.collection('cataloguedata');

  // Upload the user data to Firestore
  try {
    await cataloguecollection.doc(databasecatalogue.catalogue_title).set(databasecatalogue.toMap());
    print('catalogue data uploaded successfuly!');
  } catch (e) {
    print('Error uploading header data: $e');
  }
}



