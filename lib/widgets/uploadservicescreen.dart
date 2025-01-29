import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadServiceScreen extends StatefulWidget {
  @override
  _UploadServiceScreenState createState() => _UploadServiceScreenState();
}

class _UploadServiceScreenState extends State<UploadServiceScreen> {
  // Controllers for TextFormFields
  final TextEditingController _serviceTitleController = TextEditingController();
  final TextEditingController _serviceDescriptionController = TextEditingController();
  final TextEditingController _servicePriceKshController = TextEditingController();
  final TextEditingController _servicePriceUsdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Function to upload data to Firebase
  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('services').add({
          'service_title': _serviceTitleController.text,
          'service_description': _serviceDescriptionController.text,
          'service_priceKsh': _servicePriceKshController.text,
          'service_priceUsd': _servicePriceUsdController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Service uploaded successfully')),
        );
      //  _clearFields();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading service: $e')),
        );
      }
    }
  }

  // Clear input fields
  /*void _clearFields() {
    _serviceIdController.clear();
    _serviceTitleController.clear();
    _serviceDescriptionController.clear();
    _servicePriceKshController.clear();
    _servicePriceUsdController.clear();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _serviceTitleController,
                  decoration: InputDecoration(labelText: 'Service Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Service Title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _serviceDescriptionController,
                  decoration: InputDecoration(labelText: 'Service Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Service Description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _servicePriceKshController,
                  decoration: InputDecoration(labelText: 'Price (Ksh)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price in Ksh';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _servicePriceUsdController,
                  decoration: InputDecoration(labelText: 'Price (USD)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price in USD';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _uploadData,
                  child: Text('Upload Service'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}