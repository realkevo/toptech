import 'package:flutter/material.dart';
import 'package:toptech/stateTv/cataloguestate.dart';
import 'package:toptech/stateTv/footerstate.dart';
import 'package:toptech/stateTv/headerstate.dart';
import 'package:toptech/stateTv/servicestate.dart';

import '../stateTv/contactstate.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          color: Colors.white,
          // No need to set width and height, as Expanded will occupy available space
          child:

Column(
  children: <Widget>[
    //header container
    Container(
        color: Colors.green,
child:
Center(child: Headerstate())
    ),
    //about us container
    Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
        
            children: [
              SizedBox(height: 30,),
        
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  spacing: 13,
                  children: [
                   /* Container(
                      width: 250,
                      color: Colors.lightGreenAccent,
              
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text("About us"),
                            Center(
                              child: Text("We are a team of motivated "
                                  "\n developers, focused in \n"
                                  "providing quality vast \n "
                                  "tech services. \n based ib kenya"),
                            ),
                          ],
                        ),
                      ),),*/
                    Container(
                      height: 250,
                      width: 350,
                      color: Colors.pink,
                      child:SingleChildScrollView(
                        child: Column(
                          spacing: 5,
                          children: [
                           Text("about us",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),),
                            Container(
                              height: 2,
                              color: Colors.white,
                            ),
                        
                            Center(
                              // todo display about us description here
                              child: Container(
                                  height: 300,
                                    color: Colors.transparent,

                                    child: Text("We are a team of motivated "
                                        "\n developers, focused in \n"
                                        "providing quality vast \n "
                                        "tech services. \n ", style:
                                      TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20,
                                        color: Colors.white
                                      ),),


                                //ServiceList()),
                              ),
                            ),],
                        ),
                      ),

                    ),

                    Container(
                      width: 350,
                      color: Colors.white12,
                      child:


                          Container(
                            height: 300,
                              color: Colors.pink,
                              child: Column(
                                spacing: 3,
                                children: [
                                  Text("services",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),),
                                  Container(height: 2,
                                  color: Colors.white,),
                                  ServiceList(),
                                ],
                              )),



                    ),
                    Container(
                      width: 350,
                      color: Colors.white12,
                      child:


                      Container(
                          height: 300,
                          color: Colors.pink,
                          child: Column(
                            spacing: 3,
                            children: [
                              Text("catalogue",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),),
                              Container(height: 2,
                                color: Colors.white,),
                              CatalogueList(),
                            ],
                          )),



                    ),
                    Container(
                      width: 350,
                      color: Colors.white12,
                      child:


                      Container(
                          height: 300,
                          color: Colors.pink,
                          child: Column(
                            spacing: 3,
                            children: [
                              Text("contacts",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),),
                              Container(height: 2,
                                color: Colors.white,),
                              //todo create and call contact stream here
                              CatalogueList(),
                            ],
                          )),



                    ),
                    Container(
                      width: 350,
                      color: Colors.white12,
                      child:


                      Container(
                          height: 300,
                          color: Colors.pink,
                          child: Column(
                            spacing: 3,
                            children: [
                              Text("reviews",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),),
                              Container(height: 2,
                                color: Colors.white,),
                              //todo call reviews streamer here
                              CatalogueList(),
                            ],
                          )),



                    ),





                    //CatalogueState(),
                    /*Contactstate(),*/
                    Footerstate(),
              
              
              
              
              
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),



  ],
),

        ),
      ),
    );
  }
}