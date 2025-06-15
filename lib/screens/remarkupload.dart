/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemarkUploadClass extends StatefulWidget {
  @override
  _RemarkUploadClassState createState() => _RemarkUploadClassState();
}

class _RemarkUploadClassState extends State<RemarkUploadClass> {
  // Controllers for text form fields
  final TextEditingController _remarkNameController = TextEditingController();
  final TextEditingController _remarkDescriController = TextEditingController();
  final TextEditingController _remarkDatesController = TextEditingController();

  // Method to upload data
  void _uploadData() {
    // Get values from controllers
    String name = _remarkNameController.text;
    String specialty = _remarkDescriController.text;
    dynamic experience = int.tryParse(_remarkDatesController.text) ??
        _remarkDatesController.text; // Dynamically handle experience

    if (name.isNotEmpty && specialty.isNotEmpty && experience != null) {
      Remark teamMember = Remark(
        remarkName: name,
        remarkDescription: specialty,
        remarkDate: experience,
      );

      // Upload the data to Firestore
      teamMember.uploadToFirestore();

      // Show success message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data uploaded successfully!')));
    } else {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill in all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Colors.orange,
        height: 300,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter remarks data",
                  style: Theme.of(context).textTheme.headlineMedium),

              // Member Name Input
              TextFormField(
                controller: _remarkNameController,
                decoration: InputDecoration(labelText: 'Remarker Name'),
              ),

              // Member Specialty Input
              TextFormField(
                controller: _remarkDescriController,
                decoration: InputDecoration(labelText: 'Remark Distribution'),
              ),

              // Member Experience Input
              TextFormField(
                controller: _remarkDatesController,
                decoration: InputDecoration(labelText: 'Remark Dates'),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 20),

              // Upload Button
              ElevatedButton(
                onPressed: _uploadData,
                child: Text('Upload Data'),
              ),
            ],
          ),
        ),
      );
  }
}

class Remark {
  String remarkName;
  String remarkDescription;
  dynamic remarkDate;
  // Dynamic type for experience (can store different types)

  Remark({
    required this.remarkName,
    required this.remarkDescription,
    required this.remarkDate,
  });

  // Method to upload team member data to Firestore
  Future<void> uploadToFirestore() async {
    try {
      // Reference to Firestore 'remarkData' collection
      CollectionReference services =
      FirebaseFirestore.instance.collection('remarkData');

      // Prepare data to upload (convert Team object to Map)
      Map<String, dynamic> teamData = {
        "remarkName": remarkName,
        "remarkDescription": remarkDescription,
        "remarkDate": remarkDate,
      };

      // Upload data to Firestore, Firestore will generate a unique document ID
      var docRef = await services.add(teamData); // Automatically generates a document ID

      // You can now retrieve and store the generated docId if necessary
      String remarkId = docRef.id;  // This is the automatically generated remarkId
      print("Data uploaded successfully with remarkId: $remarkId");

      // You can also save the remarkId in Firestore if you need to associate it later:
      // await docRef.update({"remarkId": remarkId});  // Update the document with the remarkId if required.

    } catch (e) {
      // Handle any errors
      print("Error uploading data: $e");
    }
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// This widget lets you upload a remark with a name and a description.
// The timestamp is automatically generated and added upon upload.
class RemarkUploadClass extends StatefulWidget {
  @override
  _RemarkUploadClassState createState() => _RemarkUploadClassState();
}

class _RemarkUploadClassState extends State<RemarkUploadClass> {
  // Controllers for text form fields
  final TextEditingController _remarkNameController = TextEditingController();
  final TextEditingController _remarkDescriController = TextEditingController();

  // Method to upload data to Firestore
  Future<void> _uploadData() async {
    // Get values from text fields
    String name = _remarkNameController.text.trim();
    String specialty = _remarkDescriController.text.trim();

    // Check if both fields are filled
    if (name.isNotEmpty && specialty.isNotEmpty) {
      // Capture the current timestamp
      DateTime now = DateTime.now();

      // Store only day,month, and year in a convenient format
      String timestamp = "${now.day}/${now.month}/${now.year}";

      // Create a Remark object with the data
      Remark teamMember = Remark(
        remarkName: name,
        remarkDescription: specialty,
        remarkDate: timestamp,
        timestamp: now, // Store the raw timestamp for proper sorting
      );

      try {
        // Upload to Firestore
        await teamMember.uploadToFirestore();

        // Provide feedback to the user
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Data uploaded successfully!')));
      } catch (e) {
        print("Error uploading data: $e");

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error uploading data')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill in all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      height: 300,
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter remarks data",
                style: Theme.of(context).textTheme.headlineMedium),
            // Text field for the name
            TextFormField(
              controller: _remarkNameController,
              decoration: InputDecoration(labelText: 'Remarker Name'),
            ),
            // Text field for the remark’s description
            TextFormField(
              controller: _remarkDescriController,
              decoration: InputDecoration(labelText: 'Remark Distribution'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadData,
              child: Text('Upload Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class Remark {
  String remarkName;
  String remarkDescription;
  String remarkDate;
  DateTime timestamp;

  Remark({required this.remarkName, required this.remarkDescription, required this.remarkDate, required this.timestamp});

// Method to upload team member data to Firestore
  Future<void> uploadToFirestore() async {
    try {
      // Reference to Firestore 'remarkData' collection
      CollectionReference services = FirebaseFirestore.instance.collection('remarkData');

      // Prepare data to upload (convert Remark object to a map)
      Map<String, dynamic> teamData = {
        "remarkName": remarkName,
        "remarkDescription": remarkDescription,
        "remarkDate": remarkDate, // This is a human-readable format
        "timestamp": timestamp, // This is a proper timestamp for easy sorting
      };

      // Perform the upload
      var docRef = await services.add(teamData);
      String remarkId = docRef.id;

      print("Data uploaded successfully with remarkId: $remarkId");

    } catch (e) {
      // Handle any errors gracefully
      print("Error uploading data: $e");

    }
  }
}