import 'package:flutter/material.dart';
import 'package:toptech/stateTv/remarkDisplay.dart';
import 'package:toptech/stateTv/serviceDisplay.dart';
import 'package:toptech/stateTv/teamdisplay.dart';

import 'footerdisplaytv.dart';
import 'headerdisplayclass.dart';

class Homepagedisplay extends StatelessWidget {
  const Homepagedisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1,
        height:  MediaQuery.sizeOf(context).height * 1,
        child: Column(children: [
        /*  GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)
                => Mainuploadclass()),
              );
            },
            child: Text(
              'Go to Di Form Page',
              style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.none), // No underline
            ),
          ),
*/

          HeaderDisplay(),
SizedBox(height: 15,),
          Expanded(
            child: SingleChildScrollView(
              child:
              Column(children: [
                Text("SERVICES"),
                ServiceDisplayClass(),
SizedBox(height: 30,),
                Text("REMARKS AND REVIEWS"),

                RemarkDisplayClass(),

                Text("OUR TEAM"),

                TeamDisplay(),
                Align(
                  alignment: Alignment.bottomCenter,

                  child: FooterDisplayTv(),
                )
              ],),
            ),
          ),
        ],),
      ),
    );
  }
}
