import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Drawercontainer extends StatelessWidget {
  const Drawercontainer({Key ? key});

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Container(
          color: Colors.pink,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //root column
                  children: <Widget>[
                    Column(
                      //header column
                      children: [
                        Container(
                          height: 97,
                          width: 105,
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(Radius.circular(9.0))),
                          child: Image.asset(
                            'assets/images/pic.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("update"),
                            Text("remove"),
                          ],),

                      ],
                    ),
                    //closing of header column
                    SizedBox(height: 10,),
                    Center(
                      child: Container(
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Click field to edit"),
                                Text("EDIT",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ],
                            ),
                            SizedBox(height: 8,
                              child: Container(
                                color: Colors.white,
                              ),),

                            Padding(
                              padding: const EdgeInsets.only(right: 138.0),
                              child: Column(
                                //details column
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                children: <Widget>[
                                  Text("username",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text("email",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text("phone",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text("password",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],),
                            ),
                            SizedBox(height: 35,),
                            Text("Update",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,

                              ),)
                          ],
                        ),
                      ),
                    ),
                    Text("LOGOUT",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,

                      ),),


                  ],
                ),
              ),
            ),
          ),

        ),
      );


    /* Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(9.0))),
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(" update profile pic",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[


                  Text("edit",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[

                  Text("edit",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[

                  Text("edit",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[

                  Text("reset",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Row(
                children: <Widget>[
                  Text("LOGOUT",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ],
          ),

      ),
    );*/
  }
}
