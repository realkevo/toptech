import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemarkDisplayClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 300,
        height: 400,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('remarkData')
              .snapshots(), // Stream to fetch data in real-time
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No remarks found.'));
            }

            var remarks = snapshot.data!.docs;

            return ListView.builder(
              itemCount: remarks.length,
              itemBuilder: (context, index) {
                var remark = remarks[index];
                var name = remark['remarkName'];
                var description = remark['remarkDescription'];
                var date = remark['remarkDate'];

                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  child: ListTile(
                    title: Text(name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: $description'),
                        Text('Date: $date'),
                        Text('remarkName: $name'  )
                      ],
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
