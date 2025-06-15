import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

class FooterUploadData {
  String githubIcon;
  String xIcon;
  String redditIcon;
  String facebookIcon;

  // Partners
  String partnerOneIcon;
  String partnerTwoIcon;
  String partnerThreeIcon;

  // Copyright
  String copyRightIcon;

  // Addresses
  String poBoxAddress;
  String streetAddress;

  FooterUploadData({
    required this.githubIcon,
    required this.xIcon,
    required this.redditIcon,
    required this.facebookIcon,
    required this.partnerOneIcon,
    required this.partnerTwoIcon,
    required this.partnerThreeIcon,
    required this.copyRightIcon,
    required this.poBoxAddress,
    required this.streetAddress,
  });

  Future<void> uploadFooterData() async {
    try {
      CollectionReference footerDataCollection =
      FirebaseFirestore.instance.collection('footerData');

      await footerDataCollection.add({
        'githubIcon': githubIcon,
        'xIcon': xIcon,
        'redditIcon': redditIcon,
        'facebookIcon': facebookIcon,
        'partnerOneIcon': partnerOneIcon,
        'partnerTwoIcon': partnerTwoIcon,
        'partnerThreeIcon': partnerThreeIcon,
        'copyRightIcon': copyRightIcon,
        'poBoxAddress': poBoxAddress,
        'streetAddress': streetAddress,
      });

      print("Footer data uploaded successfully!");
    } catch (e) {
      print("Error uploading footer data: $e");
    }
  }
}

class UploadFooterData extends StatefulWidget {
  const UploadFooterData({super.key});

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

  final TextEditingController _poBoxController = TextEditingController();
  final TextEditingController _streetAddressController = TextEditingController();

  Future<String> _pickImageAndConvertToBase64() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      return base64Encode(Uint8List.fromList(bytes));
    }
    return '';
  }

  @override
  void dispose() {
    _poBoxController.dispose();
    _streetAddressController.dispose();
    super.dispose();
  }

  Widget _buildImagePickerTile(String title, Function(String) onSelected) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.add_a_photo),
      onTap: () async {
        String base64 = await _pickImageAndConvertToBase64();
        onSelected(base64);
        setState(() {});
      },
    );
  }

  Widget _displayImage(String? base64) {
    return (base64 == null || base64.isEmpty)
        ? const Text("No image selected")
        : Image.memory(base64Decode(base64));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Upload Footer Data",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),
              TextField(
                controller: _poBoxController,
                decoration: const InputDecoration(
                  labelText: "P.O Box Address",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _streetAddressController,
                decoration: const InputDecoration(
                  labelText: "Street Address",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              _buildImagePickerTile('Select Github Icon', (value) => _githubIconBase64 = value),
              _displayImage(_githubIconBase64),

              _buildImagePickerTile('Select X Icon', (value) => _xIconBase64 = value),
              _displayImage(_xIconBase64),

              _buildImagePickerTile('Select Reddit Icon', (value) => _redditIconBase64 = value),
              _displayImage(_redditIconBase64),

              _buildImagePickerTile('Select Facebook Icon', (value) => _facebookIconBase64 = value),
              _displayImage(_facebookIconBase64),

              _buildImagePickerTile('Select Partner One Icon', (value) => _partnerOneIconBase64 = value),
              _displayImage(_partnerOneIconBase64),

              _buildImagePickerTile('Select Partner Two Icon', (value) => _partnerTwoIconBase64 = value),
              _displayImage(_partnerTwoIconBase64),

              _buildImagePickerTile('Select Partner Three Icon', (value) => _partnerThreeIconBase64 = value),
              _displayImage(_partnerThreeIconBase64),

              _buildImagePickerTile('Select Copyright Icon', (value) => _copyRightIconBase64 = value),
              _displayImage(_copyRightIconBase64),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_poBoxController.text.isEmpty || _streetAddressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter both addresses')),
                    );
                    return;
                  }

                  FooterUploadData footerData = FooterUploadData(
                    githubIcon: _githubIconBase64 ?? '',
                    xIcon: _xIconBase64 ?? '',
                    redditIcon: _redditIconBase64 ?? '',
                    facebookIcon: _facebookIconBase64 ?? '',
                    partnerOneIcon: _partnerOneIconBase64 ?? '',
                    partnerTwoIcon: _partnerTwoIconBase64 ?? '',
                    partnerThreeIcon: _partnerThreeIconBase64 ?? '',
                    copyRightIcon: _copyRightIconBase64 ?? '',
                    poBoxAddress: _poBoxController.text,
                    streetAddress: _streetAddressController.text,
                  );

                  footerData.uploadFooterData();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Footer data uploaded!')),
                  );
                },
                child: const Text("Upload Footer Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
