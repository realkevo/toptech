import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Uploadcataloguescreen extends StatefulWidget {
  @override
  _Uploadcataloguescreen createState() => _Uploadcataloguescreen();
}

class _Uploadcataloguescreen extends State<Uploadcataloguescreen> {
  // Controllers for TextFormFields
  final TextEditingController _catalogueTitleController = TextEditingController();
  final TextEditingController _catalogueDescriptionController= TextEditingController();
//todo add imageUrl for catalogue
  final _formKey = GlobalKey<FormState>();

  // Function to upload data to Firebase
  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('catalogue').add({
          'catalogue_title': _catalogueTitleController.text,
          'catalogue_description': _catalogueDescriptionController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('catalogue uploaded successfully')),
        );
        //  _clearFields();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading catalogue: $e')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload catalogue'),
      ),
      body: Form(
        key: _formKey,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _catalogueTitleController,
              decoration: InputDecoration(labelText: 'catalogue title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter catalogue title';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _catalogueDescriptionController,
              decoration: InputDecoration(labelText: 'catalogue description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter catalogue description';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadData,
              child: Text('Upload catalogue'),
            ),
          ],
        ),

      ),

    );
  }
}