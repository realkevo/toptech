import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class HeaderDataUpload extends StatefulWidget {
  @override
  _HeaderDataUploadState createState() => _HeaderDataUploadState();
}

class _HeaderDataUploadState extends State<HeaderDataUpload> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bannerIconController = TextEditingController();
  final TextEditingController _siteTitleController = TextEditingController();
  final TextEditingController _sloganController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationTextController = TextEditingController();
  Uint8List? _imageBytes;

  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate()) {
      // Create HeaderData object
      HeaderData headerData = HeaderData(
        bannerIcon: _imageBytes != null ? base64Encode(_imageBytes!) : '',
        siteTitle: _siteTitleController.text,
        slogan: _sloganController.text,
        phoneText: _phoneTextController.text,
        email: _emailController.text,
        locationText: _locationTextController.text,
      );

      // Upload to Firestore
      await FirebaseFirestore.instance.collection('headerData').add(headerData.toMap());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data uploaded successfully!')));
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Convert the image to bytes
      _imageBytes = await image.readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 400,
        height: 500,
        color: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                Text("UPLOAD HEADER DATA", style:
                  TextStyle(
                    fontSize: 18,
                  ),),
                TextFormField(
                  controller: _bannerIconController,
                  decoration: InputDecoration(labelText: 'Banner Icon (Image URL or Base64)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;

                      //  return 'Please enter a banner icon';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                TextFormField(
                  controller: _siteTitleController,
                  decoration: InputDecoration(labelText: 'Site Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a site title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sloganController,
                  decoration: InputDecoration(labelText: 'Slogan'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a slogan';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneTextController,
                  decoration: InputDecoration(labelText: 'Phone Text'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationTextController,
                  decoration: InputDecoration(labelText: 'Location Text'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _uploadData,
                  child: Text('Upload Data'),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class HeaderData {
  String bannerIcon;
  String siteTitle;
  String slogan;
  String phoneText;
  String email;
  String locationText;

  HeaderData({
    required this.bannerIcon,
    required this.siteTitle,
    required this.slogan,
    required this.phoneText,
    required this.email,
    required this.locationText,
  });

  // Convert HeaderData to a Map
  Map<String, dynamic> toMap() {
    return {
      'bannerIcon': bannerIcon,
      'siteTitle': siteTitle,
      'slogan': slogan,
      'phoneText': phoneText,
      'email': email,
      'locationText': locationText,
    };
  }

  // Convert a Map to HeaderData
  factory HeaderData.fromMap(Map<String, dynamic> map) {
    return HeaderData(
      bannerIcon: map['bannerIcon'] ?? '',
      siteTitle: map['siteTitle'] ?? '',
      slogan: map['slogan'] ?? '',
      phoneText: map['phoneText'] ?? '',
      email: map['email'] ?? '',
      locationText: map['locationText'] ?? '',
    );
  }
}