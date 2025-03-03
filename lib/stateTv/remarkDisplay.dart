import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemarkDisplayClass extends StatefulWidget {
  @override
  _RemarkDisplayClassState createState() => _RemarkDisplayClassState();
}

class _RemarkDisplayClassState extends State<RemarkDisplayClass> {
  List<DocumentSnapshot> _remarks = []; // Store fetched remarks
  ScrollController _scrollController = ScrollController();
  bool _isScrollingForward = true; // Track scrolling direction

  @override
  void initState() {
    super.initState();
    _startAutoplay();
  }

  void _startAutoplay() {
    Future.delayed(Duration(seconds: 5), () {
      if (_remarks.isNotEmpty) {
        _scrollToNextRemark();
        _startAutoplay(); // Restart autoplay
      }
    });
  }

  void _scrollToNextRemark() {
    if (_scrollController.hasClients) {
      double targetOffset;

      if (_isScrollingForward) {
        // Scroll forward
        targetOffset = _scrollController.offset + 300; // Adjust this value based on your item width

        if (targetOffset >= _scrollController.position.maxScrollExtent) {
          // If we reach the end, switch direction
          targetOffset = _scrollController.position.maxScrollExtent;
          _isScrollingForward = false;
        }
      } else {
        // Scroll backward
        targetOffset = _scrollController.offset - 300; // Adjust this value based on your item width

        if (targetOffset <= 0) {
          // If we reach the start, switch direction
          targetOffset = 0;
          _isScrollingForward = true;
        }
      }

      // Animate to the target offset
      _scrollController.animateTo(
        targetOffset,
        duration: Duration(seconds: 6), // Duration for the scroll
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('remarkData').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No remarks found.'));
          }

          // Store the fetched remarks
          _remarks = snapshot.data!.docs;

          return ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _remarks.length,
            itemBuilder: (context, index) {
              var currentRemark = _remarks[index];
              var name = currentRemark['remarkName'];
              var description = currentRemark['remarkDescription'];
              var date = currentRemark['remarkDate'];

              return Container(
                width: 250, // Set the width of each item
                margin: EdgeInsets.all(8),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: $description'),
                        Text('Date: $date'),
                        Text('Remark Name: $name'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}