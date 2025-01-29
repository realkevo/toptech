import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Uploadcontactscreen extends StatefulWidget {
  @override
  _Uploadcontactscreen createState() => _Uploadcontactscreen();
}

class _Uploadcontactscreen extends State<Uploadcontactscreen> {
  // Controllers for TextFormFields
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactPhoneController= TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Function to upload data to Firebase
  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('contact').add({
          'contact_name': _contactNameController.text,
          'contact_email': _contactEmailController.text,
          'contact_phone': _contactPhoneController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Contact uploaded successfully')),
        );
        //  _clearFields();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading contact: $e')),
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
        title: Text('Upload data'),
      ),
      body: Form(
          key: _formKey,
        child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _contactNameController,
                  decoration: InputDecoration(labelText: 'contact name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact details';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _contactPhoneController,
                  decoration: InputDecoration(labelText: 'contact phone'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact phone';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _contactEmailController,
                  decoration: InputDecoration(labelText: 'contact email'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _uploadData,
                  child: Text('Upload contact'),
                ),
              ],
            ),

        ),

    );
  }
}