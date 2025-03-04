import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamDisplay extends StatefulWidget {
  @override
  _TeamDisplayState createState() => _TeamDisplayState();
}

class _TeamDisplayState extends State<TeamDisplay> {
  List<DocumentSnapshot> _teamMembers = []; // Store fetched team members
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startAutoplay();
  }

  void _startAutoplay() {
    Future.delayed(Duration(seconds: 5), () {
      if (_teamMembers.isNotEmpty) {
        _scrollToNextMember();
        _startAutoplay(); // Restart autoplay
      }
    });
  }

  void _scrollToNextMember() {
    if (_scrollController.hasClients) {
      double targetOffset = _scrollController.offset - 300; // Scroll to the left

      if (targetOffset <= 0) {
        // If we reach the start, reset to the end
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        targetOffset = _scrollController.position.maxScrollExtent - 300; // Move to the last item
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
      height: 300, // Set the height to 300
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('teamData').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No team members found.'));
          }

          // Store the fetched team members
          _teamMembers = snapshot.data!.docs;

          return SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _teamMembers.map((currentMember) {
                var name = currentMember['MemberName'];
                var specialty = currentMember['MemberSpecialty'];
                var experience = currentMember['MemberExperience'];

                return Container(
                  width: 300,
                  height: 200,// Set the width of each item
                  margin: EdgeInsets.all(8),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      height: 300, // Keep the height of the card as 300
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(specialty),
                          Text(experience),
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