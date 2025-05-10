import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeDrawerDataUpload {
  String? welcomeImageBase64;
  String? welcomeMessage;
  String? drawerBannerBase64;
  String? drawerAboutUs;
  String? drawerService;
  String? drawerContacts;
  String? drawerCatalogue;
  String? drawerFaqs;

  WelcomeDrawerDataUpload({
    this.welcomeImageBase64,
    this.welcomeMessage,
    this.drawerBannerBase64,
    this.drawerAboutUs,
    this.drawerService,
    this.drawerContacts,
    this.drawerCatalogue,
    this.drawerFaqs,
  });

  Map<String, dynamic> toMap() {
    return {
      'welcomeImageBase64': welcomeImageBase64,
      'welcomeMessage': welcomeMessage,
      'drawerBannerBase64': drawerBannerBase64,
      'drawerAboutUs': drawerAboutUs,
      'drawerService': drawerService,
      'drawerContacts': drawerContacts,
      'drawerCatalogue': drawerCatalogue,
      'drawerFaqs': drawerFaqs,
    };
  }

  Future<void> uploadToFirestore() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('welcome_drawer_data');
    await collection.add(this.toMap());
  }
}

class WelcomeDrawerUploadPage extends StatefulWidget {
  @override
  _WelcomeDrawerUploadPageState createState() => _WelcomeDrawerUploadPageState();
}

class _WelcomeDrawerUploadPageState extends State<WelcomeDrawerUploadPage> {
  final _formKey = GlobalKey<FormState>();
  String? _welcomeImageBase64;
  String? _drawerBannerBase64;

  final _controllers = List.generate(6, (_) => TextEditingController());

  Future<void> _pickImage(Function(String) onImagePicked) async {
    final uploadInput = html.FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        final reader = html.FileReader();
        reader.onLoadEnd.listen((event) {
          final base64 = reader.result as String;
          final cleanBase64 = base64.substring(base64.indexOf(',') + 1);
          onImagePicked(cleanBase64);
          setState(() {});
        });
        reader.readAsDataUrl(file);
      }
    });
  }

  Widget _imagePreview(String? base64) {
    return base64 == null
        ? Text('No image selected')
        : Image.memory(
      base64Decode(base64),
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    );
  }

  void _uploadData() async {
    if (!_formKey.currentState!.validate()) return;

    if (_welcomeImageBase64 == null || _drawerBannerBase64 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both Welcome Image and Drawer Banner.')),
      );
      return;
    }

    final data = WelcomeDrawerDataUpload(
      welcomeImageBase64: _welcomeImageBase64,
      welcomeMessage: _controllers[0].text,
      drawerBannerBase64: _drawerBannerBase64,
      drawerAboutUs: _controllers[1].text,
      drawerService: _controllers[2].text,
      drawerContacts: _controllers[3].text,
      drawerCatalogue: _controllers[4].text,
      drawerFaqs: _controllers[5].text,
    );

    try {
      await data.uploadToFirestore();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data uploaded successfully!')));
      _clearForm();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    }
  }

  void _clearForm() {
    setState(() {
      _welcomeImageBase64 = null;
      _drawerBannerBase64 = null;
      _controllers.forEach((c) => c.clear());
    });
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labels = [
      'Welcome Message',
      'Drawer About Us',
      'Drawer Service',
      'Drawer Contacts',
      'Drawer Catalogue',
      'Drawer FAQs',
    ];

    return
      Container(
        width: MediaQuery.sizeOf(context).width *0.8,
        height: MediaQuery.sizeOf(context).height *0.8,

        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Welcome Image', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                _imagePreview(_welcomeImageBase64),
                ElevatedButton(
                  onPressed: () => _pickImage((b64) => _welcomeImageBase64 = b64),
                  child: Text('Select Welcome Image'),
                ),
                SizedBox(height: 16),

                ...List.generate(labels.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: _controllers[i],
                      decoration: InputDecoration(
                        labelText: labels[i],
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      validator: (val) =>
                      val == null || val.trim().isEmpty ? 'Please enter ${labels[i].toLowerCase()}' : null,
                    ),
                  );
                }),

                SizedBox(height: 16),
                Text('Drawer Banner Image', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                _imagePreview(_drawerBannerBase64),
                ElevatedButton(
                  onPressed: () => _pickImage((b64) => _drawerBannerBase64 = b64),
                  child: Text('Select Drawer Banner Image'),
                ),

                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _uploadData,
                  child: Text('Upload Data'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  }
}
