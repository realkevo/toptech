import 'package:flutter/material.dart';
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
