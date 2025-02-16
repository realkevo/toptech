import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toptech/labcode/serviceformpage.dart';
import 'package:toptech/stateTv/servicestate.dart';
/*
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
              Text("OUR SERVICES"),
              //tod remove this testing button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ServiceFormPage()),
                  );
                },
                child: Text(
                  'Go to Service Form Page',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),

              // Main content - List of Services
              Expanded(
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 30,
                      children: [
                        /*   Column(
                          spacing: 20,
                          children:

                          List.generate(
                            services.length,
                                (index) =>
                                    _buildServiceItem(Databaseservice.
                                    fromDocument(services[index])),
                          ),



                        ),*/

                        Container(
                          height: 500,
                          color: Colors.white,
                          child:
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: FutureBuilder<List<Databaseservice>>(
                              future: fetchServices(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                            
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }
                            
                                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return Center(
                                      child: Text('No services available.'));
                                }
                            
                                List<Databaseservice> services = snapshot.data!;
                            
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // Number of columns
                                    crossAxisSpacing:
                                        8, // Horizontal spacing between grid items
                                    mainAxisSpacing:
                                        8, // Vertical spacing between grid items
                                  ),
                                  itemCount: services.length,
                                  itemBuilder: (context, index) {
                                    return _buildServiceItem(services[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          width: 400,
                          color: Colors.pink,
                          child: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {}, child: Text("<<")),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 10,
                                      children: List.generate(
                                        services.length,
                                        (index) => _builderRemarkItem(
                                            Databaseservice.fromDocument(
                                                services[index])),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {}, child: Text(">>")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "enter footer data here",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
  Widget _buildHeader(
      Databaseservice serviceData, List<DocumentSnapshot> services) {
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
                  _buildIconRow(serviceData.HeadLocationIconUrl!,
                      'HeadLocationText', serviceData.HeadLocationText, 30),
                if (serviceData.HeadWhatsappIconUrl != null)
                  _buildIconRow(serviceData.HeadWhatsappIconUrl!, 'WhatsApp',
                      'WhatsApp', 20),
                if (serviceData.HeadGmailIconUrl != null)
                  _buildIconRow(
                      serviceData.HeadGmailIconUrl!, 'Gmail', 'Gmail', 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build a Row with an Icon and Text
  Widget _buildIconRow(
      String iconUrl, String label, String? text, double iconSize) {
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
    return Container(
      height: 300,
      color: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            serviceData.service_title ?? 'No Title',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                  boxShadow: [],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      //  overflow: TextOverflow.ellipsis,
                      serviceData.service_description ?? 'No Description',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Prices row for services
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "price",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'ksh: ${serviceData.service_priceKsh ?? 'N/A'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'usd: ${serviceData.service_priceUsd ?? 'N/A'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                color: Colors.orange,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "INQUIRE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _builderRemarkItem(Databaseservice serviceData) {
    return Container(
      color: Colors.orange,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            serviceData.ReviewCustomerName ?? 'No customer name',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            serviceData.ReviewCustomerRemark ?? 'No customer remark',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Databaseservice>> fetchServices() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('services').get();
    return snapshot.docs
        .map((doc) => Databaseservice.fromDocument(doc))
        .toList();
  }
}

// Databaseservice class (same as you provided)
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
      'ReviewCustomerName': ReviewCustomerName,
      'ReviewCustomerRemark': ReviewCustomerRemark,
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
}*/


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
          Future<List<Databaseservice>> fetchServices() async {
            QuerySnapshot snapshot =
            await FirebaseFirestore.instance.collection('services').get();
            return snapshot.docs
                .map((doc) => Databaseservice.fromDocument(doc))
                .toList();
          }


          final services = snapshot.data!.docs;
          final serviceData = Databaseservice.fromDocument(services[0]);

          return Column(
            children: [
              // Header Container with Banner Image and Icons
              _buildHeader(serviceData, services),
              Text("OUR SERVICES"),
              //tod remove this testing button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ServiceFormPage()),
                  );
                },
                child: Text(
                  'Go to Service Form Page',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),

              // Main content - List of Services
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 30,
                      children: [
                        /*   Column(
                          spacing: 20,
                          children:

                          List.generate(
                            services.length,
                                (index) =>
                                    _buildServiceItem(Databaseservice.
                                    fromDocument(services[index])),
                          ),



                        ),*/

                        Container(
                          height: 500,
                          color: Colors.white,
                          child:
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: FutureBuilder<List<Databaseservice>>(
                                future: fetchServices(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }

                                  if (snapshot.hasError) {
                                    return Center(
                                        child: Text('Error: ${snapshot.error}'));
                                  }

                                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Center(
                                        child: Text('No services available.'));
                                  }

                                  List<Databaseservice> services = snapshot.data!;

                                  return GridView.builder(
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2, // Adjust grid columns based on screen width
                                      crossAxisSpacing:
                                      8, // Horizontal spacing between grid items
                                      mainAxisSpacing:
                                      8, // Vertical spacing between grid items
                                    ),
                                    itemCount: services.length,
                                    itemBuilder: (context, index) {
                                      return _buildServiceItem(services[index]);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.9,
                          color: Colors.pink,
                          child: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {}, child: Text("<<")),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      spacing: 10,
                                      children: List.generate(
                                        services.length,
                                            (index) => _builderRemarkItem(
                                            Databaseservice.fromDocument(
                                                services[index])),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {}, child: Text(">>")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "enter footer data here",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
  Widget _buildHeader(
      Databaseservice serviceData, List<DocumentSnapshot> services) {
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
                  _buildIconRow(serviceData.HeadLocationIconUrl!,
                      'HeadLocationText', serviceData.HeadLocationText, 30),
                if (serviceData.HeadWhatsappIconUrl != null)
                  _buildIconRow(serviceData.HeadWhatsappIconUrl!, 'WhatsApp',
                      'WhatsApp', 20),
                if (serviceData.HeadGmailIconUrl != null)
                  _buildIconRow(
                      serviceData.HeadGmailIconUrl!, 'Gmail', 'Gmail', 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build a Row with an Icon and Text
  Widget _buildIconRow(
      String iconUrl, String label, String? text, double iconSize) {
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
    return Container(
      height: 300,
      color: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            serviceData.service_title ?? 'No Title',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                  boxShadow: [],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      //  overflow: TextOverflow.ellipsis,
                      serviceData.service_description ?? 'No Description',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Prices row for services
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "price",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'ksh: ${serviceData.service_priceKsh ?? 'N/A'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'usd: ${serviceData.service_priceUsd ?? 'N/A'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                color: Colors.orange,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "INQUIRE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _builderRemarkItem(Databaseservice serviceData) {
    return Container(
      color: Colors.orange,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            serviceData.ReviewCustomerName ?? 'No customer name',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            serviceData.ReviewCustomerRemark ?? 'No customer remark',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}

// Databaseservice class (same as you provided)
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
      'ReviewCustomerName': ReviewCustomerName,
      'ReviewCustomerRemark': ReviewCustomerRemark,
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





