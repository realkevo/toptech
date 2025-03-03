/*import 'package:flutter/material.dart';
import 'package:toptech/stateTv/cataloguestate.dart';
import 'package:toptech/stateTv/footerdisplay.dart';
import 'package:toptech/stateTv/teamDisplay.dart';
import 'package:toptech/stateTv/servicestate.dart';
import '../stateTv/contactstate.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

     Column(
        children: <Widget>[
          // Header Container - Fixed, non-scrollable
          Container(
            color: Colors.green,
            child: Center(child: HeaderContainer()),
          ),
          // Main content wrapped in a SingleChildScrollView (this part will be scrollable)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Service Main Container
                  Container(
                    height: 400,
width: 600,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ServiceList(),
                    ),
                  ),
                  // Catalogue Container
                /*  Container(
                    width: 350,
                    color: Colors.white12,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.pink,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            blurRadius: 30,
                            spreadRadius: 10,
                            offset: Offset(4, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        spacing: 3,
                        children: [
                          Text(
                            "catalogue",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          CatalogueList(),
                        ],
                      ),
                    ),
                  ),*/
                  Container(
                    width: 350,
                    color: Colors.white12,
                    child: Container(
                      height: 300,
                      color: Colors.pink,
                      child: Column(
                        spacing: 3,
                        children: [
                          Text(
                            "reviews",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          // TODO: Call reviews streamer here
                          CatalogueList(),
                        ],
                      ),
                    ),
                  ),

                  // Contacts Container
                  Container(
                    width: 350,
                    color: Colors.white12,
                    child: Container(
                      height: 300,
                      color: Colors.white,
                      child:
                      Column(
                        spacing: 3,
                        children: [
                          Text(
                            "Team",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                          Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          // TODO: Create and call contact stream here
Text("Dennis Kamara"),
                          Text("Software Developer"),




                        ],
                      ),
                    ),
                  ),
                  // Reviews Container
                  // Footer Container (non-scrollable)
                  Footerstate(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
