import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddContainerUpload extends StatefulWidget {
  @override
  _AddContainerUploadState createState() => _AddContainerUploadState();
}

class _AddContainerUploadState extends State<AddContainerUpload> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _toptechSloganController = TextEditingController();
  Uint8List? _toptechIconBytes;  // To store selected image as bytes

  // Method to upload data to Firestore
  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate()) {
      // Create an instance of the UploadData class
      UploadData uploadData = UploadData(
        toptechIcon: _toptechIconBytes != null ? base64Encode(_toptechIconBytes!) : '',
        toptechSlogan: _toptechSloganController.text,
      );

      // Upload to Firestore
      await FirebaseFirestore.instance.collection('adContainer')
          .add(uploadData.toMap());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data uploaded successfully!')));

      // Clear form after successful upload
      _toptechSloganController.clear();
      setState(() {
        _toptechIconBytes = null;  // Clear selected image
      });
    }
  }

  // Method to pick an image (toptechIcon)
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Convert the image to bytes
      _toptechIconBytes = await image.readAsBytes();
      setState(() {});  // Update UI to reflect selected image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      color: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "UPLOAD TOPTECH DATA",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              // Button to pick the icon (toptechIcon)
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Toptech Icon'),
              ),
              _toptechIconBytes != null
                  ? Image.memory(
                _toptechIconBytes!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
                  : Text("No image selected"),

              // Text field for Toptech Slogan
              TextFormField(
                controller: _toptechSloganController,
                decoration: InputDecoration(labelText: 'Toptech Slogan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a slogan';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Button to upload the data to Firestore
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

class UploadData {
  String toptechIcon;
  String toptechSlogan;

  UploadData({
    required this.toptechIcon,
    required this.toptechSlogan,
  });

  // Convert UploadData to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'toptechIcon': toptechIcon,
      'toptechSlogan': toptechSlogan,
    };
  }

  // Convert a Map to UploadData (for fetching from Firestore)
  factory UploadData.fromMap(Map<String, dynamic> map) {
    return UploadData(
      toptechIcon: map['toptechIcon'] ?? '',
      toptechSlogan: map['toptechSlogan'] ?? '',
    );
  }
}
