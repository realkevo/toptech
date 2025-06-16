/*import 'package:flutter/material.dart';
import 'package:toptech/stateTv/remarkDisplay.dart';
import 'package:toptech/stateTv/serviceDisplay.dart';
import 'package:toptech/stateTv/teamdisplay.dart';

import '../widgets/advert_containerdisplay.dart';
import '../widgets/email_upload_widget.dart';
import 'footerdisplaytv.dart';

class Homepagedisplay extends StatelessWidget {
  const Homepagedisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
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

        /*  HeaderDisplay(),*/
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
                /*  GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:
                          (context) => Mainuploadclass()),
                    );
                  },
                  child: Text(
                    'Go to upload',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),*/

                Align(
                  alignment: Alignment.bottomCenter,

                  child: FooterDisplayTv(),
                )
              ],),
            ),
          ),
        ],),
      );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:toptech/stateTv/remarkDisplay.dart';
import 'package:toptech/stateTv/serviceDisplay.dart';
import 'package:toptech/stateTv/teamdisplay.dart';
import '../widgets/advert_containerdisplay.dart';
import '../widgets/email_upload_widget.dart';
import 'footerdisplaytv.dart';

class Homepagedisplay extends StatelessWidget {
  final ScrollController scrollController;
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey servicesKey;
  final GlobalKey contactsKey;
  final GlobalKey certificateKey;
  final GlobalKey faqKey;

  const Homepagedisplay({
    super.key,
    required this.scrollController,
    required this.homeKey,
    required this.aboutKey,
    required this.servicesKey,
    required this.contactsKey,
    required this.certificateKey,
    required this.faqKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0A0E21),
            Color(0xFF12233F),
            Color(0xFF1E3C72),
          ],
        ),
      ),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    key: homeKey,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "HOME",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    key: aboutKey,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "ABOUT",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    key: servicesKey,
                    padding: const EdgeInsets.all(16),
                    child: const Column(
                      children: [
                        Text(
                          "SERVICES",
                          style: TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ServiceDisplayClass(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    key: contactsKey,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "CONTACTS",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    key: certificateKey,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "CERTIFICATE",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    key: faqKey,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "FAQ",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const RemarkDisplayClass(),
                  const TeamDisplay(),
                  const SloganDisplayWidget(),
                  const MailUploadPage(),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: FooterDisplayTv(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder widgets (replace with actual implementations)
class ServiceDisplayClass extends StatelessWidget {
  const ServiceDisplayClass({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.blueGrey,
      child: const Center(child: Text('Services Content', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

class RemarkDisplayClass extends StatelessWidget {
  const RemarkDisplayClass({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.grey,
      child: const Center(child: Text('Remarks Content', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

class TeamDisplay extends StatelessWidget {
  const TeamDisplay({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.teal,
      child: const Center(child: Text('Team Content', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

class SloganDisplayWidget extends StatelessWidget {
  const SloganDisplayWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.orange,
      child: const Center(child: Text('Slogan Content', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

class MailUploadPage extends StatelessWidget {
  const MailUploadPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.purple,
      child: const Center(child: Text('Mail Upload Content', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

class FooterDisplayTv extends StatelessWidget {
  const FooterDisplayTv({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black,
      child: const Center(child: Text('Footer Content', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

