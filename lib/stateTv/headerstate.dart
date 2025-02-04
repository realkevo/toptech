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
        color: Colors.blueAccent,
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
            Container(
              color: Colors.pink,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right:  8.0),
                child: Row(
                  spacing: 20,

                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    Text("Contact Developer :  +254758536280",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),),





                  ],
                ),
              ),
            ),

            SizedBox(height: 10), // Spacing

// Row containing three containers
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right:  8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 30,
                      width: 30
                      ,  // Optional: Make the container take the full width of the screen
                      child:
                      Image.network
                        ("data:image/jpeg;base64,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"
                          "NUYZBEBn2cFMuyKcWGz+BLsuqx47fI0W73eou1R2k3djb93GNzfmeq53Jy53y3fTsijyMmd8t307EOPeonQ8SbAtGboyEK82bolRNMjgxoyScDxSMHNqK6s3jFyaSNvpIRBBHEPRGF3NFSqrUF2L+uHBBRL69jcIAgCAIAgCAIDy7xQHKvKTYDRXAXOnafo9SftMDYx/6+9Uufj8MvEj3Of1PG4J+LHo/qaYCq1oqi4CsA3S26cyW+1U1DTW+MmGMN7SSU4ceeqB8VY16i661CMenvLSrU3VXGEY9F5/0H6bXmfzZIIP6UX/rK8Z6lkPpsv0MPUr5eS9F/O5Ffe7nO4Okr5yQeDyB7Aoksq+T3c2eLybpc3JmVodLrnTgNldHUNH7xuHe0fqpFep5EOvMkV6hdDk+ZlItN/wB7biP5Js+8BSlrG/WHz/olLVOXOPz/AKEmnAxmK3HxfNj4JLWPKHzMPVPKPz/oxdZpVc6ppYx7Kdp/dDb7T8MKHZqeRPpy9CNZn3T6cjDPe57y97i5x3knJKgtuT3lzIbbb3ZQFaguR71hmSbAFozdGQhXmzdGwaP0es81Mg7o2MHM81d6PiOUvHkuXb18yywqd34jM+BhdGWZVZAQBAEAQBAEAQBARblQ09xopaSqZrxSt1SOXUdVrOCnFxfc0srjZFxl0ZxHSCyVNiuDqWpGWb4peEjefjzXOZFEqpbM5XJx5UT2ZjwV4Ec9tKwEX45MLVo23JccoWjNkyQ145rXY33LodlY2B6DsrGxkrrIBlAAUBdjdtWGZRNp3LzZujN2iifXT6oGI27Xu5Dl4qRh4ksmzb8q6sl41Dtlt5G5xxNjY1jBhrRgBdhCuMIqMeiL2KUVsj2tzIQBAEAQBAEAQBAEBQjKAxt+s1JeqJ1LVs6seN7DzC8raY2x4ZHjdTG+LjI43f7FW2Gs7CrYSx33UzR3Hjx59FQX0SpltI5jJxp0S2l08zG62Co7RHPTX4WAXmSY4rGxlMkRzdVo0bbkhk3VY2Nky62Uc1rsZ3PXaBNjO411jYbjtE2G5djftCxsEzO2C2z3ST7IYhb58uNg6DmVIxsKeTLZcl5kzGondLl08zoNHSQ0cDYYG4aPaTzK6imiFMFCC5F9XXGuPDEvr2PQIAgCAIAgCAIAgCAIAgCAi3ChprhTPp6yBk0T97XDPr8eq1lFTW0jScI2R4ZI5rpF5PqmlL6izk1EO/sT57fDmqnI09r2q+hSZOlyj7VXTyNKljkhlMUrHRvbscxwIcD1BVbKLi9mVLi4vZooHLU1PTZMcVjYzuXWzY4rGxncutn6rGxncutn6rGxnc99sOaxsZ3LkHaVErYoGPkkduYxuSVmNbk9orczFOT4Ut2blYdC5pdWa8O1GbxAw7T4lWuPpm73t+BbY2my33u5e43unp4qeFkUMbWMYMBrdwVzCEYRUYrki4hCMFwx6F1bGwQBAEAQBAEAQBAEAQBAEAQBAEBjbtZLbdmatwpIpTjAfjDx4OG0LysphavaR420VWr21uahcfJpTv1nW2ufETuZM0OA9YwVBs02H5XsV1mk1v7j2MDU+T29wuPZCCdv4myY/IqNLTrV0IctKvXTYgyaHaQMOPq6R38pC8nhXr8p4vT8lflPUeh+kLzj6ukb1cR80WFe/wAoWBkP8pkaXQC9yHExp4Bzc/P5BekdNtfXke8NLvfVpGwW/wAndJEQ64Vcs+PQjGoPbv8AcpVemVr773Jlek1r78mzbbba6G2RdnQ0sUIO8tG13id5U+uqFa2gtixqprqW0FsTMDkvQ9SqAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAID/2Q==")
                        //("https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),// Replace with your image path
                        //fit: BoxFit.cover, // Makes the image cover the container area
                      ),


                    Container(
                        height: 30,
                        width: 30
                        ,  // Optional: Make the container take the full width of the screen
                        child:
                        Image.network
                          ("data:image/jpeg;base64,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"
                            "NUYZBEBn2cFMuyKcWGz+BLsuqx47fI0W73eou1R2k3djb93GNzfmeq53Jy53y3fTsijyMmd8t307EOPeonQ8SbAtGboyEK82bolRNMjgxoyScDxSMHNqK6s3jFyaSNvpIRBBHEPRGF3NFSqrUF2L+uHBBRL69jcIAgCAIAgCAIDy7xQHKvKTYDRXAXOnafo9SftMDYx/6+9Uufj8MvEj3Of1PG4J+LHo/qaYCq1oqi4CsA3S26cyW+1U1DTW+MmGMN7SSU4ceeqB8VY16i661CMenvLSrU3VXGEY9F5/0H6bXmfzZIIP6UX/rK8Z6lkPpsv0MPUr5eS9F/O5Ffe7nO4Okr5yQeDyB7Aoksq+T3c2eLybpc3JmVodLrnTgNldHUNH7xuHe0fqpFep5EOvMkV6hdDk+ZlItN/wB7biP5Js+8BSlrG/WHz/olLVOXOPz/AKEmnAxmK3HxfNj4JLWPKHzMPVPKPz/oxdZpVc6ppYx7Kdp/dDb7T8MKHZqeRPpy9CNZn3T6cjDPe57y97i5x3knJKgtuT3lzIbbb3ZQFaguR71hmSbAFozdGQhXmzdGwaP0es81Mg7o2MHM81d6PiOUvHkuXb18yywqd34jM+BhdGWZVZAQBAEAQBAEAQBARblQ09xopaSqZrxSt1SOXUdVrOCnFxfc0srjZFxl0ZxHSCyVNiuDqWpGWb4peEjefjzXOZFEqpbM5XJx5UT2ZjwV4Ec9tKwEX45MLVo23JccoWjNkyQ145rXY33LodlY2B6DsrGxkrrIBlAAUBdjdtWGZRNp3LzZujN2iifXT6oGI27Xu5Dl4qRh4ksmzb8q6sl41Dtlt5G5xxNjY1jBhrRgBdhCuMIqMeiL2KUVsj2tzIQBAEAQBAEAQBAEBQjKAxt+s1JeqJ1LVs6seN7DzC8raY2x4ZHjdTG+LjI43f7FW2Gs7CrYSx33UzR3Hjx59FQX0SpltI5jJxp0S2l08zG62Co7RHPTX4WAXmSY4rGxlMkRzdVo0bbkhk3VY2Nky62Uc1rsZ3PXaBNjO411jYbjtE2G5djftCxsEzO2C2z3ST7IYhb58uNg6DmVIxsKeTLZcl5kzGondLl08zoNHSQ0cDYYG4aPaTzK6imiFMFCC5F9XXGuPDEvr2PQIAgCAIAgCAIAgCAIAgCAi3ChprhTPp6yBk0T97XDPr8eq1lFTW0jScI2R4ZI5rpF5PqmlL6izk1EO/sT57fDmqnI09r2q+hSZOlyj7VXTyNKljkhlMUrHRvbscxwIcD1BVbKLi9mVLi4vZooHLU1PTZMcVjYzuXWzY4rGxncutn6rGxncutn6rGxnc99sOaxsZ3LkHaVErYoGPkkduYxuSVmNbk9orczFOT4Ut2blYdC5pdWa8O1GbxAw7T4lWuPpm73t+BbY2my33u5e43unp4qeFkUMbWMYMBrdwVzCEYRUYrki4hCMFwx6F1bGwQBAEAQBAEAQBAEAQBAEAQBAEBjbtZLbdmatwpIpTjAfjDx4OG0LysphavaR420VWr21uahcfJpTv1nW2ufETuZM0OA9YwVBs02H5XsV1mk1v7j2MDU+T29wuPZCCdv4myY/IqNLTrV0IctKvXTYgyaHaQMOPq6R38pC8nhXr8p4vT8lflPUeh+kLzj6ukb1cR80WFe/wAoWBkP8pkaXQC9yHExp4Bzc/P5BekdNtfXke8NLvfVpGwW/wAndJEQ64Vcs+PQjGoPbv8AcpVemVr773Jlek1r78mzbbba6G2RdnQ0sUIO8tG13id5U+uqFa2gtixqprqW0FsTMDkvQ9SqAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAID/2Q==")
                      //("https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),// Replace with your image path
                      //fit: BoxFit.cover, // Makes the image cover the container area
                    ),

                    Container(
                        height: 30,
                        width: 30
                        ,  // Optional: Make the container take the full width of the screen
                        child:
                        Image.network
                          (
                            "data:image/jpeg;base64,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"
                            "NUYZBEBn2cFMuyKcWGz+BLsuqx47fI0W73eou1R2k3djb93GNzfmeq53Jy53y3fTsijyMmd8t307EOPeonQ8SbAtGboyEK82bolRNMjgxoyScDxSMHNqK6s3jFyaSNvpIRBBHEPRGF3NFSqrUF2L+uHBBRL69jcIAgCAIAgCAIDy7xQHKvKTYDRXAXOnafo9SftMDYx/6+9Uufj8MvEj3Of1PG4J+LHo/qaYCq1oqi4CsA3S26cyW+1U1DTW+MmGMN7SSU4ceeqB8VY16i661CMenvLSrU3VXGEY9F5/0H6bXmfzZIIP6UX/rK8Z6lkPpsv0MPUr5eS9F/O5Ffe7nO4Okr5yQeDyB7Aoksq+T3c2eLybpc3JmVodLrnTgNldHUNH7xuHe0fqpFep5EOvMkV6hdDk+ZlItN/wB7biP5Js+8BSlrG/WHz/olLVOXOPz/AKEmnAxmK3HxfNj4JLWPKHzMPVPKPz/oxdZpVc6ppYx7Kdp/dDb7T8MKHZqeRPpy9CNZn3T6cjDPe57y97i5x3knJKgtuT3lzIbbb3ZQFaguR71hmSbAFozdGQhXmzdGwaP0es81Mg7o2MHM81d6PiOUvHkuXb18yywqd34jM+BhdGWZVZAQBAEAQBAEAQBARblQ09xopaSqZrxSt1SOXUdVrOCnFxfc0srjZFxl0ZxHSCyVNiuDqWpGWb4peEjefjzXOZFEqpbM5XJx5UT2ZjwV4Ec9tKwEX45MLVo23JccoWjNkyQ145rXY33LodlY2B6DsrGxkrrIBlAAUBdjdtWGZRNp3LzZujN2iifXT6oGI27Xu5Dl4qRh4ksmzb8q6sl41Dtlt5G5xxNjY1jBhrRgBdhCuMIqMeiL2KUVsj2tzIQBAEAQBAEAQBAEBQjKAxt+s1JeqJ1LVs6seN7DzC8raY2x4ZHjdTG+LjI43f7FW2Gs7CrYSx33UzR3Hjx59FQX0SpltI5jJxp0S2l08zG62Co7RHPTX4WAXmSY4rGxlMkRzdVo0bbkhk3VY2Nky62Uc1rsZ3PXaBNjO411jYbjtE2G5djftCxsEzO2C2z3ST7IYhb58uNg6DmVIxsKeTLZcl5kzGondLl08zoNHSQ0cDYYG4aPaTzK6imiFMFCC5F9XXGuPDEvr2PQIAgCAIAgCAIAgCAIAgCAi3ChprhTPp6yBk0T97XDPr8eq1lFTW0jScI2R4ZI5rpF5PqmlL6izk1EO/sT57fDmqnI09r2q+hSZOlyj7VXTyNKljkhlMUrHRvbscxwIcD1BVbKLi9mVLi4vZooHLU1PTZMcVjYzuXWzY4rGxncutn6rGxncutn6rGxnc99sOaxsZ3LkHaVErYoGPkkduYxuSVmNbk9orczFOT4Ut2blYdC5pdWa8O1GbxAw7T4lWuPpm73t+BbY2my33u5e43unp4qeFkUMbWMYMBrdwVzCEYRUYrki4hCMFwx6F1bGwQBAEAQBAEAQBAEAQBAEAQBAEBjbtZLbdmatwpIpTjAfjDx4OG0LysphavaR420VWr21uahcfJpTv1nW2ufETuZM0OA9YwVBs02H5XsV1mk1v7j2MDU+T29wuPZCCdv4myY/IqNLTrV0IctKvXTYgyaHaQMOPq6R38pC8nhXr8p4vT8lflPUeh+kLzj6ukb1cR80WFe/wAoWBkP8pkaXQC9yHExp4Bzc/P5BekdNtfXke8NLvfVpGwW/wAndJEQ64Vcs+PQjGoPbv8AcpVemVr773Jlek1r78mzbbba6G2RdnQ0sUIO8tG13id5U+uqFa2gtixqprqW0FsTMDkvQ9SqAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAID/2Q==")
                      //("https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),// Replace with your image path
                      //fit: BoxFit.cover, // Makes the image cover the container area
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





// Widget for reusable container
class ContainerBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}



