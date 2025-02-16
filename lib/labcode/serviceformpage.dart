/*import 'dart:convert'; // To encode the image to Base64
import 'dart:typed_data'; // To use Uint8List
import 'dart:html' as html; // For image picking on Flutter Web
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ServiceFormPage extends StatefulWidget {
  @override
  _ServiceFormPageState createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  // Hold Base64 encoded image strings
  String? base64BannerImage;
  String? base64WhatsappIcon;
  String? base64LocationIcon;
  String? base64GmailIcon;

  // Hold image bytes for preview
  Uint8List? bannerImageBytes;
  Uint8List? whatsappIconBytes;
  Uint8List? locationIconBytes;
  Uint8List? gmailIconBytes;

  // Text Controllers for the form fields
  TextEditingController serviceTitleController = TextEditingController();
  TextEditingController serviceDescriptionController = TextEditingController();
  TextEditingController servicePriceKshController = TextEditingController();
  TextEditingController servicePriceUsdController = TextEditingController();
  TextEditingController serviceLocationTextController = TextEditingController();
  TextEditingController servicePhoneNumberController = TextEditingController();

  // Function to select and encode the banner image to Base64
  Future<void> selectBannerImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      bannerImageBytes = result.files.single.bytes;

      if (bannerImageBytes != null) {
        String base64String = base64Encode(bannerImageBytes!);

        setState(() {
          base64BannerImage = base64String;
        });
      } else {
        print('File does not have valid bytes');
      }
    } else {
      print('No file selected');
    }
  }

  // Function to select and encode the Whatsapp icon image to Base64
  Future<void> selectWhatsappIcon() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      whatsappIconBytes = result.files.single.bytes;

      if (whatsappIconBytes != null) {
        String base64String = base64Encode(whatsappIconBytes!);

        setState(() {
          base64WhatsappIcon = base64String;
        });
      } else {
        print('File does not have valid bytes');
      }
    } else {
      print('No file selected');
    }
  }

  // Function to select and encode the Location icon image to Base64
  Future<void> selectLocationIcon() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      locationIconBytes = result.files.single.bytes;

      if (locationIconBytes != null) {
        String base64String = base64Encode(locationIconBytes!);

        setState(() {
          base64LocationIcon = base64String;
        });
      } else {
        print('File does not have valid bytes');
      }
    } else {
      print('No file selected');
    }
  }

  // Function to select and encode the Gmail icon image to Base64
  Future<void> selectGmailIcon() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      gmailIconBytes = result.files.single.bytes;

      if (gmailIconBytes != null) {
        String base64String = base64Encode(gmailIconBytes!);

        setState(() {
          base64GmailIcon = base64String;
        });
      } else {
        print('File does not have valid bytes');
      }
    } else {
      print('No file selected');
    }
  }

  // Function to upload service data to Firestore
  Future<void> uploadService(Databaseservice service) async {
    try {
      // Adding service data to Firestore
      await FirebaseFirestore.instance.collection('services').add(service.toMap());
      print('Service uploaded successfully!');
    } catch (e) {
      print('Error uploading service: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Service")),
      body: SingleChildScrollView( // Making the form scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input fields for service information
            TextField(
              controller: serviceTitleController,
              decoration: InputDecoration(labelText: 'Service Title'),
            ),
            TextField(
              controller: serviceDescriptionController,
              decoration: InputDecoration(labelText: 'Service Description'),
            ),
            TextField(
              controller: servicePriceKshController,
              decoration: InputDecoration(labelText: 'Price in Ksh'),
            ),
            TextField(
              controller: servicePriceUsdController,
              decoration: InputDecoration(labelText: 'Price in USD'),
            ),
            TextField(
              controller: serviceLocationTextController,
              decoration: InputDecoration(labelText: 'Location Text'),
            ),
            TextField(
              controller: servicePhoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),

            // Button to select Banner image
            ElevatedButton(
              onPressed: selectBannerImage,
              child: Text("Select Banner Image"),
            ),
            SizedBox(height: 10),
            if (bannerImageBytes != null)
              Image.memory(bannerImageBytes!), // Preview the banner image

            SizedBox(height: 20),

            // Button to select Whatsapp icon
            ElevatedButton(
              onPressed: selectWhatsappIcon,
              child: Text("Select Whatsapp Icon"),
            ),
            SizedBox(height: 10),
            if (whatsappIconBytes != null)
              Image.memory(whatsappIconBytes!), // Preview the Whatsapp icon

            SizedBox(height: 20),

            // Button to select Location icon
            ElevatedButton(
              onPressed: selectLocationIcon,
              child: Text("Select Location Icon"),
            ),
            SizedBox(height: 10),
            if (locationIconBytes != null)
              Image.memory(locationIconBytes!), // Preview the Location icon

            SizedBox(height: 20),

            // Button to select Gmail icon
            ElevatedButton(
              onPressed: selectGmailIcon,
              child: Text("Select Gmail Icon"),
            ),
            SizedBox(height: 10),
            if (gmailIconBytes != null)
              Image.memory(gmailIconBytes!), // Preview the Gmail icon

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Gather all form data
                Databaseservice newService = Databaseservice(
                  service_title: serviceTitleController.text,
                  service_description: serviceDescriptionController.text,
                  service_priceKsh: servicePriceKshController.text,
                  service_priceUsd: servicePriceUsdController.text,
                  HeadLocationText: serviceLocationTextController.text,
                  HeadPhoneNumber: servicePhoneNumberController.text,
                  HeadWhatsappIconUrl: base64WhatsappIcon,
                  HeadLocationIconUrl: base64LocationIcon,
                  HeadGmailIconUrl: base64GmailIcon,
                  HeadBannerImage: base64BannerImage,
                );

                uploadService(newService); // Upload service data to Firestore
              },
              child: Text("Upload Service"),
            ),
          ],
        ),
      ),
    );
  }
}

// Databaseservice class for structure
class Databaseservice {
  String? service_title;
  String? service_description;
  String? service_priceKsh;
  String? service_priceUsd;
  String? HeadLocationText;
  String? HeadPhoneNumber;
  String? HeadWhatsappIconUrl;
  String? HeadLocationIconUrl;
  String? HeadBannerImage;
  String? HeadGmailIconUrl;

  //todo add review fields

  //REVIEW FIELDS
  String? ReviewCustomerName;
  String? ReviewCustomerRemark;


  Databaseservice({
    this.service_title,
    this.service_description,
    this.service_priceKsh,
    this.service_priceUsd,
    this.HeadLocationText,
    this.HeadPhoneNumber,
    this.HeadWhatsappIconUrl,
    this.HeadLocationIconUrl,
    this.HeadGmailIconUrl,
    this.HeadBannerImage,
    this.ReviewCustomerName,
    this.ReviewCustomerRemark,
  });

  Map<String, dynamic> toMap() {
    return {
      'service_title': service_title,
      'service_description': service_description,
      'service_priceKsh': service_priceKsh,
      'service_priceUsd': service_priceUsd,
      'HeadLocationText': HeadLocationText,
      'HeadPhoneNumber': HeadPhoneNumber,
      'HeadWhatsappIconUrl': HeadWhatsappIconUrl,
      'HeadLocationIconUrl': HeadLocationIconUrl,
      'HeadGmailIconUrl': HeadGmailIconUrl,
      'HeadBannerImage': HeadBannerImage,
      'ReviewCustomerName' : ReviewCustomerName,
      'ReviewCustomerRemark' : ReviewCustomerRemark,

    };
  }

  factory Databaseservice.fromDocument(DocumentSnapshot doc) {
    return Databaseservice(
      service_title: doc['service_title'],
      service_description: doc['service_description'],
      service_priceKsh: doc['service_priceKsh'],
      service_priceUsd: doc['service_priceUsd'],
      HeadLocationText: doc['HeadLocationText'],
      HeadPhoneNumber: doc['HeadPhoneNumber'],
      HeadWhatsappIconUrl: doc['HeadWhatsappIconUrl'],
      HeadLocationIconUrl: doc['HeadLocationIconUrl'],
      HeadGmailIconUrl: doc['HeadGmailIconUrl'],
      HeadBannerImage: doc['HeadBannerImage'],
        ReviewCustomerRemark: doc['ReviewCustomerRemark'],
        ReviewCustomerName: doc['ReviewCustomerName'],
    );
  }
}
*/
import 'dart:convert'; // To encode the image to Base64
import 'dart:typed_data'; // To use Uint8List
import 'dart:html' as html; // For image picking on Flutter Web
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toptech/labcode/ui/servicedisplaypage.dart';

class ServiceFormPage extends StatefulWidget {
  @override
  _ServiceFormPageState createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  // Hold Base64 encoded image strings
  String? base64BannerImage;
  String? base64WhatsappIcon;
  String? base64LocationIcon;
  String? base64GmailIcon;

  // Hold image bytes for preview
  Uint8List? bannerImageBytes;
  Uint8List? whatsappIconBytes;
  Uint8List? locationIconBytes;
  Uint8List? gmailIconBytes;

  // Text Controllers for the form fields
  TextEditingController serviceTitleController = TextEditingController();
  TextEditingController serviceDescriptionController = TextEditingController();
  TextEditingController servicePriceKshController = TextEditingController();
  TextEditingController servicePriceUsdController = TextEditingController();
  TextEditingController serviceLocationTextController = TextEditingController();
  TextEditingController servicePhoneNumberController = TextEditingController();

  // New Review fields
  TextEditingController reviewCustomerNameController = TextEditingController();
  TextEditingController reviewCustomerRemarkController = TextEditingController();

  // Function to select and encode the banner image to Base64
  Future<void> selectBannerImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      bannerImageBytes = result.files.single.bytes;

      if (bannerImageBytes != null) {
        String base64String = base64Encode(bannerImageBytes!);

        setState(() {
          base64BannerImage = base64String;
        });
      } else {
        print('File does not have valid bytes');
      }
    } else {
      print('No file selected');
    }
  }

  // Function to select and encode the Whatsapp icon image to Base64
  Future<void> selectWhatsappIcon() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      whatsappIconBytes = result.files.single.bytes;

      if (whatsappIconBytes != null) {
        String base64String = base64Encode(whatsappIconBytes!);

        setState(() {
          base64WhatsappIcon = base64String;
        });
      } else {
        print('File does not have valid bytes');
      }
    } else {
      print('No file selected');
    }
  }

  // Function to select and encode the Location icon image to Base64
  Future<void> selectLocationIcon() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      locationIconBytes = result.files.single.bytes;

      if (locationIconBytes != null) {
        String base64String = base64Encode(locationIconBytes!);

        setState(() {
          base64LocationIcon = base64String;
        });
      } else {
        print('File does not have valid bytes');
      }
    } else {
      print('No file selected');
    }
  }

  // Function to select and encode the Gmail icon image to Base64
  Future<void> selectGmailIcon() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      gmailIconBytes = result.files.single.bytes;

      if (gmailIconBytes != null) {
        String base64String = base64Encode(gmailIconBytes!);

        setState(() {
          base64GmailIcon = base64String;
        });
      } else {
        print('File does not have valid bytes');
      }
    } else {
      print('No file selected');
    }
  }

  // Function to upload service data to Firestore
  Future<void> uploadService(Databaseservice service) async {
    try {
      // Adding service data to Firestore
      await FirebaseFirestore.instance.collection('services').add(service.toMap());
      print('Service uploaded successfully!');
    } catch (e) {
      print('Error uploading service: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Service")),
      body: SingleChildScrollView( // Making the form scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceDisplayPage()),
                );
              },
              child: Text(
                'Go to Service Display Page',
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
            )
,
            // Input fields for service information
            TextField(
              controller: serviceTitleController,
              decoration: InputDecoration(labelText: 'Service Title'),
            ),
            TextField(
              controller: serviceDescriptionController,
              decoration: InputDecoration(labelText: 'Service Description'),
            ),
            TextField(
              controller: servicePriceKshController,
              decoration: InputDecoration(labelText: 'Price in Ksh'),
            ),
            TextField(
              controller: servicePriceUsdController,
              decoration: InputDecoration(labelText: 'Price in USD'),
            ),
            TextField(
              controller: serviceLocationTextController,
              decoration: InputDecoration(labelText: 'Location Text'),
            ),
            TextField(
              controller: servicePhoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            // New Review fields
            TextField(
              controller: reviewCustomerNameController,
              decoration: InputDecoration(labelText: 'Customer Name'),
            ),
            TextField(
              controller: reviewCustomerRemarkController,
              decoration: InputDecoration(labelText: 'Customer Remark'),
            ),
            SizedBox(height: 20),

            // Button to select Banner image
            ElevatedButton(
              onPressed: selectBannerImage,
              child: Text("Select Banner Image"),
            ),
            SizedBox(height: 10),
            if (bannerImageBytes != null)
              Image.memory(bannerImageBytes!), // Preview the banner image

            SizedBox(height: 20),

            // Button to select Whatsapp icon
            ElevatedButton(
              onPressed: selectWhatsappIcon,
              child: Text("Select Whatsapp Icon"),
            ),
            SizedBox(height: 10),
            if (whatsappIconBytes != null)
              Image.memory(whatsappIconBytes!), // Preview the Whatsapp icon

            SizedBox(height: 20),

            // Button to select Location icon
            ElevatedButton(
              onPressed: selectLocationIcon,
              child: Text("Select Location Icon"),
            ),
            SizedBox(height: 10),
            if (locationIconBytes != null)
              Image.memory(locationIconBytes!), // Preview the Location icon

            SizedBox(height: 20),

            // Button to select Gmail icon
            ElevatedButton(
              onPressed: selectGmailIcon,
              child: Text("Select Gmail Icon"),
            ),
            SizedBox(height: 10),
            if (gmailIconBytes != null)
              Image.memory(gmailIconBytes!), // Preview the Gmail icon

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Gather all form data
                Databaseservice newService = Databaseservice(
                  service_title: serviceTitleController.text,
                  service_description: serviceDescriptionController.text,
                  service_priceKsh: servicePriceKshController.text,
                  service_priceUsd: servicePriceUsdController.text,
                  HeadLocationText: serviceLocationTextController.text,
                  HeadPhoneNumber: servicePhoneNumberController.text,
                  HeadWhatsappIconUrl: base64WhatsappIcon,
                  HeadLocationIconUrl: base64LocationIcon,
                  HeadGmailIconUrl: base64GmailIcon,
                  HeadBannerImage: base64BannerImage,
                  ReviewCustomerName: reviewCustomerNameController.text,
                  ReviewCustomerRemark: reviewCustomerRemarkController.text,
                );

                uploadService(newService); // Upload service data to Firestore
              },
              child: Text("Upload Service"),
            ),
          ],
        ),
      ),
    );
  }
}

// Databaseservice class for structure
class Databaseservice {
  String? service_title;
  String? service_description;
  String? service_priceKsh;
  String? service_priceUsd;
  String? HeadLocationText;
  String? HeadPhoneNumber;
  String? HeadWhatsappIconUrl;
  String? HeadLocationIconUrl;
  String? HeadBannerImage;
  String? HeadGmailIconUrl;

  // Review Fields
  String? ReviewCustomerName;
  String? ReviewCustomerRemark;

  Databaseservice({
    this.service_title,
    this.service_description,
    this.service_priceKsh,
    this.service_priceUsd,
    this.HeadLocationText,
    this.HeadPhoneNumber,
    this.HeadWhatsappIconUrl,
    this.HeadLocationIconUrl,
    this.HeadGmailIconUrl,
    this.HeadBannerImage,
    this.ReviewCustomerName,
    this.ReviewCustomerRemark,
  });

  Map<String, dynamic> toMap() {
    return {
      'service_title': service_title,
      'service_description': service_description,
      'service_priceKsh': service_priceKsh,
      'service_priceUsd': service_priceUsd,
      'HeadLocationText': HeadLocationText,
      'HeadPhoneNumber': HeadPhoneNumber,
      'HeadWhatsappIconUrl': HeadWhatsappIconUrl,
      'HeadLocationIconUrl': HeadLocationIconUrl,
      'HeadGmailIconUrl': HeadGmailIconUrl,
      'HeadBannerImage': HeadBannerImage,
      'ReviewCustomerName' : ReviewCustomerName,
      'ReviewCustomerRemark' : ReviewCustomerRemark,
    };
  }

  factory Databaseservice.fromDocument(DocumentSnapshot doc) {
    return Databaseservice(
      service_title: doc['service_title'],
      service_description: doc['service_description'],
      service_priceKsh: doc['service_priceKsh'],
      service_priceUsd: doc['service_priceUsd'],
      HeadLocationText: doc['HeadLocationText'],
      HeadPhoneNumber: doc['HeadPhoneNumber'],
      HeadWhatsappIconUrl: doc['HeadWhatsappIconUrl'],
      HeadLocationIconUrl: doc['HeadLocationIconUrl'],
      HeadGmailIconUrl: doc['HeadGmailIconUrl'],
      HeadBannerImage: doc['HeadBannerImage'],
      ReviewCustomerRemark: doc['ReviewCustomerRemark'],
      ReviewCustomerName: doc['ReviewCustomerName'],
    );
  }
}
