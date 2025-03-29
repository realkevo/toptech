import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart'; // For input formatting

// MailUploadWidget Model
class MailUploadWidget {
  String email;
  int phone;
  String mailMessage;

  // Constructor
  MailUploadWidget({
    required this.email,
    required this.phone,
    required this.mailMessage,
  });

  // Method to convert the object to a map for Firestore upload
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
      'mailMessage': mailMessage,
    };
  }

  // Method to upload data to Firestore
  Future<void> uploadToFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('MailData').add(toMap());
      print("Data uploaded successfully!");
    } catch (e) {
      print("Failed to upload data: $e");
    }
  }
}

class MailUploadPage extends StatefulWidget {
  @override
  _MailUploadPageState createState() => _MailUploadPageState();
}

class _MailUploadPageState extends State<MailUploadPage> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  // Regular expression for validating email format
  final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  // Function to handle form submission
  void _submitForm() {
    String email = _emailController.text;
    int? phone = int.tryParse(_phoneController.text);
    String mailMessage = _messageController.text;

    // Validate that either email or phone is filled
    if (email.isEmpty && (phone == null || phone == 0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter either phone or email')),
      );
      return;
    }

    // Validate email format
    if (email.isNotEmpty && !_emailRegExp.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    // Validate phone number length
    if (phone != null && _phoneController.text.length >= 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number should be less than 15 characters')),
      );
      return;
    }

    // Validate message field
    if (mailMessage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in the Message')),
      );
      return;
    }

    // Create the MailUploadWidget object
    final mailData = MailUploadWidget(
      email: email,
      phone: phone ?? 0, // Use 0 if phone is null
      mailMessage: mailMessage,
    );

    // Upload the data to Firestore
    mailData.uploadToFirestore().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text('Mail sent!'))),
      );

      // Clear input fields after upload
      _emailController.clear();
      _phoneController.clear();
      _messageController.clear();
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email: $e')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text("LEAVE A MESSAGE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.white
              ),),
              SizedBox(height: 20,),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Valid Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,  // Center-align the typed text

              ),
              SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,  // Center-align the typed text


                inputFormatters: [
                  LengthLimitingTextInputFormatter(14), // Limit phone number to 14 characters
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Leave A Message',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,  // Center-align the typed text


              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('SEND'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
