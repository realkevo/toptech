import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 400,
        height: 400,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('teamData')
              .snapshots(), // Stream of data from Firestore
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No team members found.'));
            }

            var teamMembers = snapshot.data!.docs;

            return ListView.builder(
              itemCount: teamMembers.length,
              itemBuilder: (context, index) {
                var teamMember = teamMembers[index];
                var name = teamMember['MemberName'];
                var specialty = teamMember['MemberSpecialty'];
                var experience = teamMember['MemberExperience'];

                return Container(
                  color: Colors.orange,
                  width: 100,
                  child: Card(
                    margin: EdgeInsets.all(8),
                    elevation: 4,
                    child:  Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(name),
                            Text( specialty),
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
