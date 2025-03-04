import 'package:flutter/material.dart';
class Headerdisplayclass extends StatelessWidget {
  const Headerdisplayclass({super.key});

  @override
  Widget build(BuildContext context) {
    return
        Container(
          height: 80,
          width: MediaQuery.sizeOf(context).width * 1,
          color: Colors.orange,
          child: Center(child: Text("enter headerdata here")),
        );
  }
}
