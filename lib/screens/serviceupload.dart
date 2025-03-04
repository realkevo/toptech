import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Service App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddServicePage(), // Navigate to AddServicePage on launch
    );
  }
}

// Service Model Class (without serviceId)
class Service {
  String serviceTitle;
  String serviceDescription;
  String servicePriceKsh;
  String servicePriceUsd;

  Service({
    required this.serviceTitle,
    required this.serviceDescription,
    required this.servicePriceKsh,
    required this.servicePriceUsd,
  });

  // Convert Service object to a Map (used to upload to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'serviceTitle': serviceTitle,
      'serviceDescription': serviceDescription,
      'servicePriceKsh': servicePriceKsh,
      'servicePriceUsd': servicePriceUsd,
    };
  }

  // Factory constructor to create Service from a Map (Firestore data)
  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      serviceTitle: map['serviceTitle'] ?? '',
      serviceDescription: map['serviceDescription'] ?? '',
      servicePriceKsh: map['servicePriceKsh'] ?? '',
      servicePriceUsd: map['servicePriceUsd'] ?? '',
    );
  }
}

// Firestore Service to upload data to Firebase Firestore
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to add a service to Firestore
  Future<void> addService(Service service) async {
    try {
      // Using 'auto ID' generation by Firestore, removing the serviceId
      await _db.collection('servicesData').add(service.toMap());
    } catch (e) {
      print('Error adding service: $e');
    }
  }
}

// AddServicePage - UI for adding a service
class AddServicePage extends StatefulWidget {
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceKshController = TextEditingController();
  final TextEditingController _priceUsdController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 360,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Service Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Service Description'),
            ),
            TextField(
              controller: _priceKshController,
              decoration: InputDecoration(labelText: 'Service Price (Ksh)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _priceUsdController,
              decoration: InputDecoration(labelText: 'Service Price (USD)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String title = _titleController.text;
                final String description = _descriptionController.text;
                final String priceKsh = _priceKshController.text;
                final String priceUsd = _priceUsdController.text;

                // Create a new Service object
                final service = Service(
                  serviceTitle: title,
                  serviceDescription: description,
                  servicePriceKsh: priceKsh,
                  servicePriceUsd: priceUsd,
                );

                // Upload service to Firestore
                _firestoreService.addService(service);

                // Clear the text fields
                _titleController.clear();
                _descriptionController.clear();
                _priceKshController.clear();
                _priceUsdController.clear();

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Service added successfully!')),
                );
              },
              child: Text('Add Service'),
            ),
          ],
        ),
      );
  }
}
