import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewsClass extends StatefulWidget {
  @override
  _ReviewsClassState createState() => _ReviewsClassState();
}

class _ReviewsClassState extends State<ReviewsClass> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Databaseservice> _reviews = [];
  int _currentIndex = 0; // Change to track the current index

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    QuerySnapshot snapshot = await _firestore.collection('services').get();
    setState(() {
      _reviews = snapshot.docs.map((doc) => Databaseservice.fromDocument(doc)).toList();
    });
  }

  void _nextReview() {
    if (_currentIndex < _reviews.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _prevReview() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current review
    Databaseservice currentReview = _reviews.isNotEmpty ? _reviews[_currentIndex] : Databaseservice();

    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            currentReview.ReviewCustomerName ?? 'No Name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(currentReview.ReviewCustomerRemark ?? 'No Remark',
            style:  TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 250,
            color: Colors.black,
            child: Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: _prevReview, child: Text("<<")),
                SizedBox(width: 30,),
                ElevatedButton(
                    onPressed: _nextReview, child: Text(">>")),

              ],
            ),
          ),


        ],
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
