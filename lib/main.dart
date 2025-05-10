import 'package:anydrawer/anydrawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toptech/screens/mainuploadclass.dart';
import 'package:toptech/stateTv/desktophomepagedisplay.dart';
import 'package:toptech/stk/stkpush.dart';
import 'package:toptech/uploaddata/uploaddata.dart';
import 'package:toptech/widgets/advert_containerdisplay.dart';
import 'package:toptech/widgets/splash_screen.dart';
import 'firebase_options.dart';
import 'labcode/testwidget/testwidget.dart';

import 'package:flutter/material.dart';
//import 'home_page_display.dart'; // Make sure this file exists

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      demoProjectId: "toptech-1dc04",
      options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Scaffold(
        body: Mainuploadclass(),
      ),
    );
  }
}




/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    demoProjectId: "toptech-1dc04",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp.router(
      title: 'techforce.co.ke',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: AnyDrawerRouterDelegate(
        builder: (context) => const MyHomePage(title: 'Techforce',),
      ),
    );
  }
}

class AnyDrawerRouterDelegate extends RouterDelegate<Uri>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Uri> {
  AnyDrawerRouterDelegate({required this.builder});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: builder(context),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        notifyListeners();
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Uri? get currentConfiguration => null;

  @override
  Future<void> setNewRoutePath(Uri configuration) async {}
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DrawerConfig config = const DrawerConfig(side: DrawerSide.left); // Set the drawer to slide from the left
  final AnyDrawerController controller = AnyDrawerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showDrawer() {
    showDrawer(
      context,
      builder: (context) => const DrawerContent(),
      config: config,
      onClose: () {
        debugPrint('Drawer closed');
      },
      onOpen: () {
        debugPrint('Drawer opened');
      },
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      // Reducing the height of the header container
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50), // Set a smaller height (50) for the header
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0A0E21), // Dark blue
                Color(0xFF0A0E21), // Slightly lighter blue
                Color(0xFF1E3C72), // Mid blue
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: _showDrawer, // Show the drawer when the button is pressed
              ),
            ],
          ),
        ),
      ),
      body: Homepagedisplay(), // Your main content
    );
  }
}*/


class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black, // Start color
            Colors.blue,  // End color
          ],
          begin: Alignment.topLeft, // Gradient starts from the top left
          end: Alignment.bottomRight, // Gradient ends at the bottom right
        ),
      ),
      child:
      Center(
        child: const Text(
          'Coming Soon...',
          style: TextStyle(
            color: Colors.white, // Change text color to white for better visibility
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}