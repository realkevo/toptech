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

class RemarkUploadClass extends StatefulWidget {
  const RemarkUploadClass({super.key});

  @override
  _RemarkUploadClassState createState() => _RemarkUploadClassState();
}

class _RemarkUploadClassState extends State<RemarkUploadClass> {
  final TextEditingController _remarkNameController = TextEditingController();
  final TextEditingController _remarkDescriController = TextEditingController();

  Future<void> _uploadData() async {
    String name = _remarkNameController.text.trim();
    String description = _remarkDescriController.text.trim();

    if (name.isNotEmpty && description.isNotEmpty) {
      DateTime now = DateTime.now();

      // Format date string as day/month/year
      String formattedDate = "${now.day.toString().padLeft(2,'0')}/${now.month.toString().padLeft(2,'0')}/${now.year}";

      Remark remark = Remark(
        remarkName: name,
        remarkDescription: description,
        remarkDate: formattedDate, // only store formatted string, no Timestamp field anymore
      );

      try {
        await remark.uploadToFirestore();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data uploaded successfully!')),
        );
        _remarkNameController.clear();
        _remarkDescriController.clear();
      } catch (e) {
        print("Error uploading data: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading data')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      height: 300,
      width: 400,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter remarks data",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextFormField(
            controller: _remarkNameController,
            decoration: InputDecoration(labelText: 'Remarker Name'),
          ),
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
    );
  }
}

class Remark {
  final String remarkName;
  final String remarkDescription;
  final String remarkDate; // human-readable formatted date string

  Remark({
    required this.remarkName,
    required this.remarkDescription,
    required this.remarkDate,
  });

  Future<void> uploadToFirestore() async {
    CollectionReference remarksCollection =
        FirebaseFirestore.instance.collection('remarkData');

    Map<String, dynamic> data = {
      "remarkName": remarkName,
      "remarkDescription": remarkDescription,
      "remarkDate": remarkDate, // just a formatted string
    };

    await remarksCollection.add(data);
  }
}