import 'package:flutter/material.dart';
import 'package:toptech/labcode/ui/servicedisplaypage.dart';
import 'package:toptech/screens/headerdataupload.dart';
import 'package:toptech/screens/remarkupload.dart';
import 'package:toptech/screens/serviceupload.dart';
import 'package:toptech/screens/teamupload.dart';

import '../stateTv/serviceDisplay.dart';
import 'footerdataupload.dart';

class Mainuploadclass extends StatelessWidget {
  const Mainuploadclass({super.key});

  @override
  Widget build(BuildContext context) {
    return
Scaffold(
  body: SingleChildScrollView(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceDisplayPage()),
                );
              },
              child: Text(
                'Go to Display Form Page',
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceDisplayClass()),
                );
              },
              child: Text(
                'Go to Display Form Page',
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ),

            AddServicePage(),
            RemarkUploadClass(),
            UploadFooterData(),
            TeamUploadClass(),
            HeaderDataUpload(),

          ]
        ),
      ),
    ),
  ),
);  }
}
