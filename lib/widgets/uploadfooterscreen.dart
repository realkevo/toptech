import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Uploadfooterscreen extends StatefulWidget {
  @override
  _Uploadfooterscreen createState() => _Uploadfooterscreen();
}

class _Uploadfooterscreen extends State<Uploadfooterscreen> {
  // Controllers for TextFormFields
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerEmailLink = TextEditingController();
  final TextEditingController _controllerRedditLink = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Function to upload data to Firebase
  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('footer').add({
          'footer_phone': _controllerPhone.text,
          'footer_email_link': _controllerEmailLink.text,
          'footer_reddit_link': _controllerRedditLink.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('footer details uploaded successfully')),
        );
        //  _clearFields();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading footer details: $e')),
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
        title: Text('Upload footer data'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _controllerPhone,
              decoration: InputDecoration(labelText: 'footer phone'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone details';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _controllerEmailLink,
              decoration: InputDecoration(labelText: 'email footer link'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email footer';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _controllerRedditLink,
              decoration: InputDecoration(labelText: 'input reddit link'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter reddit link';
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _uploadData,
              child: Text('Upload footer'),
            ),
          ],
        ),
      ),
    );
  }
}
