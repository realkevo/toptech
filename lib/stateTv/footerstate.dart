import 'package:flutter/material.dart';

class Footerstate extends StatelessWidget {
  const Footerstate({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        color: Colors.blueAccent,
        child: Column(
          children: <Widget>[
            //todo add contact icons and relevant methods
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 10,
                  width: 20,
                  color: Colors.white,
                ),
                Container(
                  height: 10,
                  width: 20,
                  color: Colors.white,
                ),
                Container(
                  height: 10,
                  width: 20,
                  color: Colors.white,
                ),
              ],
            ),
            //todo add partners icons here
            Row(
              spacing: 3,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 10,
                  width: 20,
                  color: Colors.white,
                ),
                Container(
                  height: 10,
                  width: 20,
                  color: Colors.white,
                ),
                Container(
                  height: 10,
                  width: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ));
  }
}
