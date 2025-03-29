import 'package:flutter/material.dart';
import 'package:toptech/stateTv/remarkDisplay.dart';
import 'package:toptech/stateTv/serviceDisplay.dart';
import 'package:toptech/stateTv/teamdisplay.dart';

import '../widgets/advert_containerdisplay.dart';
import '../widgets/email_upload_widget.dart';
import 'footerdisplaytv.dart';
import 'headerdisplayclass.dart';

class Homepagedisplay extends StatelessWidget {
  const Homepagedisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0E21), // Dark blue
              Color(0xFF12233F), // Slightly lighter blue
              Color(0xFF1E3C72), // Mid blue
            ],
          ),


        ),

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
                Text("SERVICES",
                style:
                TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,

                ),),
                ServiceDisplayClass(),
SizedBox(height: 30,),


                RemarkDisplayClass(),



                TeamDisplay(),
                SloganDisplayWidget(),
                MailUploadPage(),

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
