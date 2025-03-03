import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TeamUploadClass extends StatefulWidget {
  @override
  _TeamUploadClassState createState() => _TeamUploadClassState();
}

class _TeamUploadClassState extends State<TeamUploadClass> {
  // Controllers for text form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  // Method to upload data
  void _uploadData() {
    // Get values from controllers
    String name = _nameController.text;
    String specialty = _specialtyController.text;
    dynamic experience =
        int.tryParse(_experienceController.text)
            ?? _experienceController.text; // Dynamically handle experience

    if (name.isNotEmpty && specialty.isNotEmpty && experience != null) {
      Team teamMember = Team(
        memberName: name,
        memberSpecialty: specialty,
        memberExperience: experience,
      );

      // Upload the data to Firestore
      teamMember.uploadToFirestore();

      // Show success message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data uploaded successfully!')));
    } else {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color:  Colors.orange,
        height: 300,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter Team Member Details", style: Theme.of(context)
                  .textTheme.headlineMedium),

              // Member Name Input
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Member Name'),
              ),

              // Member Specialty Input
              TextFormField(
                controller: _specialtyController,
                decoration: InputDecoration(labelText: 'Member Specialty'),
              ),

              // Member Experience Input
              TextFormField(
                controller: _experienceController,
                decoration: InputDecoration(labelText: 'Member Experience'),
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



class Team {
  String memberName;
  String memberSpecialty;
  dynamic memberExperience;
  // Dynamic type for experience (can store different types)

  Team({
    required this.memberName,
    required this.memberSpecialty,
    required this.memberExperience,
  });

  // Method to upload team member data to Firestore
  Future<void> uploadToFirestore() async {
    try {
      // Reference to Firestore 'services' collection
      CollectionReference services = FirebaseFirestore.instance.
      collection('teamData');

      // Prepare data to upload (convert Team object to Map)
      Map<String, dynamic> teamData = {
        "MemberName": memberName,
        "MemberSpecialty": memberSpecialty,
        "MemberExperience": memberExperience,
      };

      // Upload data to Firestore, where the document ID is the member's name
      await services.doc(memberName).set(teamData);

      // Notify success
      print("Data uploaded successfully!");
    } catch (e) {
      // Handle any errors
      print("Error uploading data: $e");
    }
  }
}
