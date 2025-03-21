import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemarkDisplayClass extends StatefulWidget {
  @override
  _RemarkDisplayClassState createState() => _RemarkDisplayClassState();
}

class _RemarkDisplayClassState extends State<RemarkDisplayClass> {
  List<DocumentSnapshot> _remarks = []; // Store fetched remarks
  ScrollController _scrollController = ScrollController();

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
      double targetOffset = _scrollController.offset + 250; // Adjust this value based on your item width

      if (targetOffset >= _scrollController.position.maxScrollExtent) {
        // If we reach the end, reset to the start
        _scrollController.jumpTo(0);
        targetOffset = 250; // Move to the first item in the second list
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
    return
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('remarkData').
          snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
        
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No remarks found.'));
            }
        
            // Store the fetched remarks
            _remarks = snapshot.data!.docs;
        
            // Create a duplicated list for seamless scrolling
            List<DocumentSnapshot> duplicatedRemarks = [..._remarks, ..._remarks];
        
            return SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 13,
                children: duplicatedRemarks.map((currentRemark) {
                  var name = currentRemark['remarkName'];
                  var description = currentRemark['remarkDescription'];
                  var date = currentRemark['remarkDate'];
        
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF0A0E21), // Dark blue
                            Color(0xFF12233F), // Slightly lighter blue
                            Color(0xFF1E3C72), // Mid blue
                          ],
                        ),


                      ),

                      width: 250,
                      height: 180,
                      // Set the width of each item
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,

                              ),
                            ),
                            SizedBox(height: 4),
                            Text(description,
                              style:
                              TextStyle(
                                color: Colors.white,
                              ),),
                            SizedBox(height: 4),
                            Text('  $date',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic

                              ),),
                          ],
                        ),
                      ),

                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      );
  }
}