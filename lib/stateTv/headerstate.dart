import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayHeaderService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('services').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No header service data available.'));
        }

        // Get the latest document
        var docData = snapshot.data!.docs.first.data()
        as Map<String, dynamic>;

        String? bannerImage = docData['HeadBannerImage'];
        String? locationIcon = docData['HeadLocationIconUrl'];
        String? whatsappIcon = docData['HeadWhatsappIconUrl'];
        String? gmailIcon = docData['HeadGmailIconUrl'];
        String? locationText = docData['HeadLocationText'];
        String? phoneNumber = docData['HeadPhoneNumber'];

        return Container(
          padding: EdgeInsets.all(16.0),
          child:
          Column(
            children: [
              // Display Banner Image
              if (bannerImage != null && bannerImage.isNotEmpty)
                Image.network(
                  bannerImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(child: Text('No Banner Image',
        style: TextStyle(fontSize: 10),),
        )),


              SizedBox(height: 20),

              // Display icons in a Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Location Icon
                  Column(
                    children: [
                      if (locationIcon != null && locationIcon.isNotEmpty)
                        Image.network(locationIcon, height: 50, width: 50)
                      else
                        Text("location icon not found",
                        style: TextStyle(fontSize: 10),
                        ),
                      SizedBox(height: 5),
                      Text(locationText ?? 'No Location',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),

                  // WhatsApp Icon
                  if (whatsappIcon != null && whatsappIcon.isNotEmpty)
                    Image.network(whatsappIcon, height: 50, width: 50)
                  else
                    Icon(Icons.add, size: 50),

                  // Gmail Icon
                  if (gmailIcon != null && gmailIcon.isNotEmpty)
                    Image.network(gmailIcon, height: 50, width: 50)
                  else
                    Icon(Icons.email, size: 50),
                ],
              ),

              SizedBox(height: 10),

              // Display Phone Number
              Text(
                phoneNumber ?? 'No Phone Number',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
