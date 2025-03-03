import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toptech/screens/footerdataupload.dart';
import 'package:toptech/screens/mainuploadclass.dart';
import 'package:toptech/screens/remarkupload.dart';
import 'package:toptech/screens/teamupload.dart';
import 'package:toptech/stateTv/footerdisplayTv.dart';
import 'package:toptech/stateTv/remarkDisplay.dart';
import 'package:toptech/stateTv/teamDisplay.dart';
import 'firebase_options.dart';
import 'labcode/ui/servicedisplaypage.dart';


void main() async {


  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    demoProjectId: "toptech-1dc04",
   options: DefaultFirebaseOptions.currentPlatform,

 );
 /* await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // stateTv is not lost during the reload. To reset the stateTv, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
        ServiceDisplayPage(),
      //UploadHeaderService(),
     // DisplayHeaderService(),
     // ReviewsClass(),
     // UploadFooterData(),
     // ReviewsPagination(),
      //ServiceFormPage(),
     // ContactScreen(),
    //  Mainuploadclass(),      //TeamClass(),
      //FooterDisplayTv(),

     // ServicePage(),


     //ServiceFormPage(),
      //ServiceList(),
     // Uploaddata(),
      //Homepage(),
    // UploadServiceScreen(),
      //Homepage(),
      //ServiceDisplayPage( ),
    );
  }
}


