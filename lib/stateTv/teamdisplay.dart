import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamDisplay extends StatefulWidget {
  @override
  _TeamDisplayState createState() => _TeamDisplayState();
}

class _TeamDisplayState extends State<TeamDisplay> {
  List<DocumentSnapshot> _teams = []; // Store fetched remarks
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startAutoplay();
  }

  void _startAutoplay() {
    Future.delayed(Duration(seconds: 5), () {
      if (_teams.isNotEmpty) {
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
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 190,
      child:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('teamData').
        snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No team  found.'));
          }

          // Store the fetched remarks
          _teams = snapshot.data!.docs;

          // Create a duplicated list for seamless scrolling
          List<DocumentSnapshot> duplicatedRemarks = [..._teams, ..._teams];

          return SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 13,
              children: duplicatedRemarks.map((currentMember) {
                var name = currentMember['MemberName'];
                var specialty = currentMember['MemberSpecialty'];
                var experience = currentMember['MemberExperience'];

                return Container(
                  width: 250,
                  height: 150,
                  // Set the width of each item
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text('specialty: $specialty'),
                          SizedBox(height: 4),
                          Text('experience: $experience'),
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