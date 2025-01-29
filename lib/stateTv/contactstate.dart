import 'package:flutter/material.dart';
class Contactstate extends StatelessWidget {
  const Contactstate({super.key});

  @override
  Widget build(BuildContext context) {
return Container(
  height: 400,

  color: Colors.white12,
  child: Column(

    children: <Widget> [
      Text("contacts", style:
      TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),),

      //todo insert the services cardviews here

    ],
  ),
);
  }
}
