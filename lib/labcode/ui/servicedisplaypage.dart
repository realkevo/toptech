import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toptech/stateTv/servicestate.dart';

class ServiceDisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('services').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No services available'));
          }

          final services = snapshot.data!.docs;
          final serviceData = Databaseservice.fromDocument(services[0]);

          return Column(
            children: [
              // Header Container with Banner Image and Icons
              _buildHeader(serviceData, services),

              // Main content - List of Services
              Expanded(
                child: SingleChildScrollView(
                  child:
                  Column(
                    children: [
                      Column(
                        children: List.generate(
                          services.length,
                              (index) =>
                                  _buildServiceItem(Databaseservice.
                                  fromDocument(services[index])),
                        ),


                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1,
                      color: Colors.blue,
                        child: Center(
                          child: Text("enter footer data here", style:
                            TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 20),),
                        ),

                      ),
                    ],
                  ),

                ),
              ),


            ],
          );
        },
      ),
    );
  }

  // Header Section
  Widget _buildHeader(Databaseservice serviceData,
      List<DocumentSnapshot> services) {
    return Container(
      width: double.infinity,
      color: Colors.green,
      child: Column(
        children: [
          if (services.isNotEmpty && serviceData.HeadBannerImage != null)
            Container(
              height: 100,
              child: Image.memory(
                base64Decode(serviceData.HeadBannerImage!),
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (serviceData.HeadLocationIconUrl != null)
                  _buildIconRow(serviceData.HeadLocationIconUrl!, 'HeadLocationText', serviceData.HeadLocationText, 30),
                if (serviceData.HeadWhatsappIconUrl != null)
                  _buildIconRow(serviceData.HeadWhatsappIconUrl!, 'WhatsApp', 'WhatsApp', 20),
                if (serviceData.HeadGmailIconUrl != null)
                  _buildIconRow(serviceData.HeadGmailIconUrl!, 'Gmail', 'Gmail', 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build a Row with an Icon and Text
  Widget _buildIconRow(String iconUrl, String label,
      String? text, double iconSize) {
    return Row(
      children: [
        Image.memory(
          base64Decode(iconUrl),
          height: iconSize,
          width: iconSize,
        ),
        SizedBox(width: 5),
        Text(
          text ?? label,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  // Service Item Container
  Widget _buildServiceItem(Databaseservice serviceData) {
    return
      Column(
        spacing: 10,
        children: [
          SizedBox(height: 10,),
          Container(
          height: 300,
          width: 400,
          color: Colors.yellow,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  serviceData.service_title ?? 'No Title',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  serviceData.service_priceUsd ?? 'No Price',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  serviceData.service_description ?? 'No Description',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
              ),
          // TODO return services reviewDATA HERE
          Container(
            height: 300,
            width: 400,
            color: Colors.yellow,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    serviceData.service_title ?? 'No Title',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    serviceData.service_priceUsd ?? 'No Price',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    serviceData.service_description ?? 'No Description',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),


        ],
      );
  }
}


// Databaseservice class (same as you provided)
class Databaseservice {
  String? service_title;
  String? service_description;
  String? service_priceKsh;
  String? service_priceUsd;
  String? HeadBannerImage;
  String? HeadLocationIconUrl;
  String? HeadLocationText;
  String? HeadWhatsappIconUrl;
  String? HeadGmailIconUrl;
  String? HeadPhoneNumber;

  Databaseservice({
    this.service_title,
    this.service_description,
    this.service_priceKsh,
    this.service_priceUsd,
    this.HeadBannerImage,
    this.HeadLocationIconUrl,
    this.HeadLocationText,
    this.HeadWhatsappIconUrl,
    this.HeadGmailIconUrl,
    this.HeadPhoneNumber,
  });

  factory Databaseservice.fromDocument(DocumentSnapshot doc) {
    return Databaseservice(
      service_title: doc['service_title'],
      service_description: doc['service_description'],
      service_priceKsh: doc['service_priceKsh'],
      service_priceUsd: doc['service_priceUsd'],
      HeadBannerImage: doc['HeadBannerImage'],
      HeadLocationIconUrl: doc['HeadLocationIconUrl'],
      HeadLocationText: doc['HeadLocationText'],
      HeadWhatsappIconUrl: doc['HeadWhatsappIconUrl'],
      HeadGmailIconUrl: doc['HeadGmailIconUrl'],
      HeadPhoneNumber: doc['HeadPhoneNumber'],
    );
  }
}
