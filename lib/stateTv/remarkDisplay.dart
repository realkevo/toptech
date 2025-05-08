import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemarkDisplayClass extends StatefulWidget {
  @override
  _RemarkDisplayClassState createState() => _RemarkDisplayClassState();
}

class _RemarkDisplayClassState extends State<RemarkDisplayClass> {
  List<DocumentSnapshot> _remarks = [];
  ScrollController _scrollController = ScrollController();
  bool _isPointerDown = false;

  @override
  void initState() {
    super.initState();
    _startAutoplay();
  }

  void _startAutoplay() async {
    while (mounted) {
      await Future.delayed(Duration(seconds: 5));
      if (!_isPointerDown && _remarks.isNotEmpty) {
        _scrollToNextRemark();
      }
    }
  }

  void _scrollToNextRemark() {
    if (_scrollController.hasClients) {
      double targetOffset = _scrollController.offset + 250;

      if (targetOffset >= _scrollController.position.maxScrollExtent) {
        _scrollController.jumpTo(0);
        targetOffset = 250;
      }

      _scrollController.animateTo(
        targetOffset,
        duration: Duration(seconds: 6),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20, top: 40),
      child: Column(
        children: [
          Text(
            "REVIEWS",
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('remarkData').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No remarks found.'));
              }

              _remarks = snapshot.data!.docs;
              List<DocumentSnapshot> duplicatedRemarks = [..._remarks, ..._remarks];

              return Listener(
                onPointerDown: (_) {
                  setState(() {
                    _isPointerDown = true;
                  });
                },
                onPointerUp: (_) {
                  setState(() {
                    _isPointerDown = false;
                  });
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: duplicatedRemarks.map((currentRemark) {
                      var name = currentRemark['remarkName'];
                      var description = currentRemark['remarkDescription'];
                      var date = currentRemark['remarkDate'];

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 250,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.lightGreenAccent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF0A0E21),
                              Color(0xFF1E3C72),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              description,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '$date',
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
