import 'package:flutter/material.dart';

import '../widgets/uploadcataloguescreen.dart';
import '../widgets/uploadcontactscreen.dart';
import '../widgets/uploadfooterscreen.dart';
import '../widgets/uploadheaderscreen.dart';
import '../widgets/uploadservicescreen.dart';
class Uploaddata extends StatelessWidget {
  const Uploaddata({super.key});

  @override
  Widget build(BuildContext context) {
return Container(
  height: MediaQuery.sizeOf(context).height,
  width: MediaQuery.sizeOf(context).width,

  child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      children: <Widget>[
        Uploadcontactscreen(),
        UploadServiceScreen(),
        Uploadcataloguescreen(),
        Uploadheaderscreen(),
        Uploadfooterscreen(),
      ],
    ),
  ),
);  }
}
/*
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child:
        GestureDetector(
          onTap: () {
            // Navigate to the SecondScreen when the text is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
          child: Text(
            'Click me to navigate!',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Second Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}*/