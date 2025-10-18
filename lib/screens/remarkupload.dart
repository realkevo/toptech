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