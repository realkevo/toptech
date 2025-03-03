import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert'; // For base64 encoding
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data'; // For image byte manipulation

class FooterUploadData {
  String githubIcon;
  String xIcon;
  String redditIcon;
  String facebookIcon;

  // partners
  String partnerOneIcon;
  String partnerTwoIcon;
  String partnerThreeIcon;

  // Copyright
  String copyRightIcon;

  // Constructor
  FooterUploadData({
    required this.githubIcon,
    required this.xIcon,
    required this.redditIcon,
    required this.facebookIcon,
    required this.partnerOneIcon,
    required this.partnerTwoIcon,
    required this.partnerThreeIcon,
    required this.copyRightIcon,
  });

  // Method to upload data to Firestore
  Future<void> uploadFooterData() async {
    try {
      // Create a reference to the Firestore collection
      CollectionReference footerDataCollection =
      FirebaseFirestore.instance.collection('footerData');

      // Set the data
      await footerDataCollection.add({
        'githubIcon': githubIcon,
        'xIcon': xIcon,
        'redditIcon': redditIcon,
        'facebookIcon': facebookIcon,
        'partnerOneIcon': partnerOneIcon,
        'partnerTwoIcon': partnerTwoIcon,
        'partnerThreeIcon': partnerThreeIcon,
        'copyRightIcon': copyRightIcon,
      });

      print("Footer data uploaded successfully!");
    } catch (e) {
      print("Error uploading footer data: $e");
    }
  }
}

class UploadFooterData extends StatefulWidget {
  @override
  _UploadFooterDataState createState() => _UploadFooterDataState();
}

class _UploadFooterDataState extends State<UploadFooterData> {
  final ImagePicker _picker = ImagePicker();
  String? _githubIconBase64;
  String? _xIconBase64;
  String? _redditIconBase64;
  String? _facebookIconBase64;
  String? _partnerOneIconBase64;
  String? _partnerTwoIconBase64;
  String? _partnerThreeIconBase64;
  String? _copyRightIconBase64;

  // Method to pick and convert image to base64
  Future<String> _pickImageAndConvertToBase64() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Convert to bytes
      final bytes = await image.readAsBytes();
      // Convert bytes to Base64
      return base64Encode(Uint8List.fromList(bytes));
    }
    return ''; // Return an empty string if no image selected
  }

  // UI for selecting images
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 500,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Upload Footer Data", style:
                  TextStyle(
                    fontSize: 20,
                  ),),
                // Github Icon Picker
                ListTile(
                  title: Text('Select Github Icon'),
                  trailing: Icon(Icons.add_a_photo),
                  onTap: () async {
                    _githubIconBase64 = await _pickImageAndConvertToBase64();
                    setState(() {});
                  },
                ),
                _githubIconBase64 == null
                    ? Text("No image selected")
                    : Image.memory(base64Decode(_githubIconBase64!)),

                // X Icon Picker
                ListTile(
                  title: Text('Select X Icon'),
                  trailing: Icon(Icons.add_a_photo),
                  onTap: () async {
                    _xIconBase64 = await _pickImageAndConvertToBase64();
                    setState(() {});
                  },
                ),
                _xIconBase64 == null
                    ? Text("No image selected")
                    : Image.memory(base64Decode(_xIconBase64!)),

                // Reddit Icon Picker
                ListTile(
                  title: Text('Select Reddit Icon'),
                  trailing: Icon(Icons.add_a_photo),
                  onTap: () async {
                    _redditIconBase64 = await _pickImageAndConvertToBase64();
                    setState(() {});
                  },
                ),
                _redditIconBase64 == null
                    ? Text("No image selected")
                    : Image.memory(base64Decode(_redditIconBase64!)),

                // Facebook Icon Picker
                ListTile(
                  title: Text('Select Facebook Icon'),
                  trailing: Icon(Icons.add_a_photo),
                  onTap: () async {
                    _facebookIconBase64 = await _pickImageAndConvertToBase64();
                    setState(() {});
                  },
                ),
                _facebookIconBase64 == null
                    ? Text("No image selected")
                    : Image.memory(base64Decode(_facebookIconBase64!)),

                // Partner One Icon Picker
                ListTile(
                  title: Text('Select Partner One Icon'),
                  trailing: Icon(Icons.add_a_photo),
                  onTap: () async {
                    _partnerOneIconBase64 = await _pickImageAndConvertToBase64();
                    setState(() {});
                  },
                ),
                _partnerOneIconBase64 == null
                    ? Text("No image selected")
                    : Image.memory(base64Decode(_partnerOneIconBase64!)),

                // Partner Two Icon Picker
                ListTile(
                  title: Text('Select Partner Two Icon'),
                  trailing: Icon(Icons.add_a_photo),
                  onTap: () async {
                    _partnerTwoIconBase64 = await _pickImageAndConvertToBase64();
                    setState(() {});
                  },
                ),
                _partnerTwoIconBase64 == null
                    ? Text("No image selected")
                    : Image.memory(base64Decode(_partnerTwoIconBase64!)),

                // Partner Three Icon Picker
                ListTile(
                  title: Text('Select Partner Three Icon'),
                  trailing: Icon(Icons.add_a_photo),
                  onTap: () async {
                    _partnerThreeIconBase64 = await _pickImageAndConvertToBase64();
                    setState(() {});
                  },
                ),
                _partnerThreeIconBase64 == null
                    ? Text("No image selected")
                    : Image.memory(base64Decode(_partnerThreeIconBase64!)),

                // Copyright Icon Picker
                ListTile(
                  title: Text('Select Copyright Icon'),
                  trailing: Icon(Icons.add_a_photo),
                  onTap: () async {
                    _copyRightIconBase64 = await _pickImageAndConvertToBase64();
                    setState(() {});
                  },
                ),
                _copyRightIconBase64 == null
                    ? Text("No image selected")
                    : Image.memory(base64Decode(_copyRightIconBase64!)),

                // Upload Button
                ElevatedButton(
                  onPressed: () {
                    FooterUploadData footerData = FooterUploadData(
                      githubIcon: _githubIconBase64 ?? '',
                      xIcon: _xIconBase64 ?? '',
                      redditIcon: _redditIconBase64 ?? '',
                      facebookIcon: _facebookIconBase64 ?? '',
                      partnerOneIcon: _partnerOneIconBase64 ?? '',
                      partnerTwoIcon: _partnerTwoIconBase64 ?? '',
                      partnerThreeIcon: _partnerThreeIconBase64 ?? '',
                      copyRightIcon: _copyRightIconBase64 ?? '',
                    );
                    footerData.uploadFooterData();
                  },
                  child: Text("Upload Footer Data"),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

