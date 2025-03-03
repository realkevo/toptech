import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamDisplay extends StatefulWidget {
  @override
  _TeamDisplayState createState() => _TeamDisplayState();
}

class _TeamDisplayState extends State<TeamDisplay> {
  List<DocumentSnapshot> _teamMembers = []; // Store fetched team members
  ScrollController _scrollController = ScrollController();
  bool _isScrollingForward = true; // Track scrolling direction

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
      width: 400,
      height: 400,
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

          return ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _teamMembers.length,
            itemBuilder: (context, index) {
              var currentMember = _teamMembers[index];
              var name = currentMember['MemberName'];
              var specialty = currentMember['MemberSpecialty'];
              var experience = currentMember['MemberExperience'];

              return Container(
                width: 300, // Set the width of each item
                margin: EdgeInsets.all(8),
                child: Card(
                  elevation: 4,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
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
            },
          );
        },
      ),
    );
  }
}