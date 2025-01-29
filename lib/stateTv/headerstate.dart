/*import 'package:flutter/material.dart';
class Headerstate extends StatelessWidget {
  const Headerstate({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Row(
      spacing: 10,
      children: [
        Container(
          width: 50,height: 50,
          color: Colors.red,
        ),
        Column(
          spacing: 10,
          children: <Widget>[
            Text("Top tech services"),
            Text("Affordable quality tech services",)
          ],
        )
      ],
    );
}
}
*/
/*import 'package:flutter/material.dart';


class Headerstate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return
      Center(
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.pink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // First Column
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.red),
                  SizedBox(height: 8),
                  Text('Top Tech'),
                  Container(
                    width: 100, // Adjust the width
                    height: 50, // Adjust the height
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child:
                    Image.asset('assets/images/toptechlogo.jpg'),
                  ),
                ],
              ),

              // Second Column
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8),
                  Text('TOP TECH SERVICES',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange
                  ),),
                  Text('affordable cyber hook!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),),


                ],
              ),

              // Third Column
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.settings, color: Colors.blue),
                  SizedBox(height: 8),
                  Text('Column 3'),
                ],
              ),
            ],
          ),
        ),
      );
*/
    /*  Padding(
      padding: const EdgeInsets.all(6.0), // Add padding for better UI
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Container(
              width: 115,
              //width: screenWidth * 0.2, // Adjust size relative to screen width
              height: screenWidth * 0.1,
              color: Colors.red,
            ),
           // SizedBox(width: screenWidth * 0.01), // Responsive spacing

            Center(
              child: Container(
                color: Colors.blueAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    //todo fetch and display database data here
                    Center(
                      child: Text(
                        "Top tech services",
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,

                          fontSize: screenWidth * 0.04, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.01), // Responsive spacing

                    /*GradientText(
                            "Affordable quality tech services",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          )*/
                    Container(height: 1,
                      color: Colors.white,),
                    Text(
                      "Affordable quality tech services",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontStyle: FontStyle.normal, // Makes the text italic
                        fontSize: 18, // Adjust font size as needed
                        fontWeight: FontWeight.w600, // Slightly bold for emphasis
                        color: Colors.white, // Stylish accent color
                        letterSpacing: 1.5, // Adds spacing between letters
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0), // Creates a shadow offset
                            blurRadius: 4.0, // Blurs the shadow
                            color: Colors.grey.withOpacity(0.5), // Shadow color with transparency
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center, // Center aligns the text
                    ),               ],
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
 /* }
}*/
import 'package:flutter/material.dart';

class  Headerstate extends StatelessWidget {
  const Headerstate({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return

      Container(
        child: Column(
          children: [
// Banner Text
            Container(
              height: 80,
              color: Colors.pink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "banner here",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Spacing

// Row containing three containers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContainerBox(),
                ContainerBox(),
                ContainerBox(),
              ],
            ),
          ],
        ),
      );
  }
}





// Widget for reusable container
class ContainerBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}



