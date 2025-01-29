import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Uploadheaderscreen extends StatefulWidget {
  @override
  _Uploadheaderscreen createState() => _Uploadheaderscreen();
}

class _Uploadheaderscreen extends State<Uploadheaderscreen> {
  // Controllers for TextFormFields
  final TextEditingController _headerTitleController = TextEditingController();
  final TextEditingController _headerSloganController = TextEditingController();

  //todo enter header mode toggle button
  //todo enter drawer pull button

  final _formKey = GlobalKey<FormState>();

  // Function to upload data to Firebase
  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('headerData').add({
          'header_title': _headerTitleController.text,
          'contact_email': _headerSloganController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('header data uploaded successfully')),
        );
        //  _clearFields();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading header: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload header data'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _headerTitleController,
              decoration: InputDecoration(labelText: 'header title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter header details';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _headerSloganController,
              decoration: InputDecoration(labelText: 'header slogan'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter header slogan';
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _uploadData,
              child: Text('Upload header'),
            ),
          ],
        ),
      ),
    );
  }
}
