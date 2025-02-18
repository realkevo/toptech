import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



class ReviewsPagination extends StatefulWidget {
  @override
  _ReviewsPaginationState createState() => _ReviewsPaginationState();
}

class _ReviewsPaginationState extends State<ReviewsPagination> {
  List<Databaseservice> reviews = [];
  int currentIndex = 0;
  int pageSize = 5; // Number of reviews per page

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('services')
        .doc('96BlTao190AlIPj3Erms') // Replace with actual document ID
        .get();

    if (doc.exists) {
      List<dynamic> fetchedItems = doc['items']; // Get array data
      List<Databaseservice> reviewList = fetchedItems.map((item) {
        return Databaseservice(
          ReviewCustomerName: item['ReviewCustomerName'],
          ReviewCustomerRemark: item['ReviewCustomerRemark'],
        );
      }).toList();

      setState(() {
        reviews = reviewList;
      });
    }
  }

  List<Databaseservice> getCurrentPageItems() {
    int start = currentIndex;
    int end = (currentIndex + pageSize) > reviews.length ? reviews.length : (currentIndex + pageSize);
    return reviews.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    List<Databaseservice> displayedItems = getCurrentPageItems();

    return Scaffold(
      appBar: AppBar(title: Text('Paginated Reviews')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: displayedItems.length,
              itemBuilder: (context, index) {
                var review = displayedItems[index];
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.ReviewCustomerName ?? 'Anonymous',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        review.ReviewCustomerRemark ?? 'No review provided.',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: currentIndex == 0 ? null : () {
                  setState(() {
                    currentIndex -= pageSize;
                    if (currentIndex < 0) currentIndex = 0;
                  });
                },
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: (currentIndex + pageSize) >= reviews.length ? null : () {
                  setState(() {
                    currentIndex += pageSize;
                  });
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
