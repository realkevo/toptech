import 'dart:convert';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:anydrawer/anydrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toptech/stateTv/desktophomepagedisplay.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    demoProjectId: "toptech-1dc04",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeSplash(),
  ));
}

class WelcomeDrawerDataUpload {
  String? welcomeImageBase64;
  String? welcomeMessage;
  String? drawerBannerBase64;
  String? drawerAboutUs;
  String? drawerService;
  String? drawerContacts;
  String? drawerCatalogue;
  String? drawerFaqs;

  WelcomeDrawerDataUpload({
    this.welcomeImageBase64,
    this.welcomeMessage,
    this.drawerBannerBase64,
    this.drawerAboutUs,
    this.drawerService,
    this.drawerContacts,
    this.drawerCatalogue,
    this.drawerFaqs,
  });

  factory WelcomeDrawerDataUpload.fromFirestore(Map<String, dynamic> map) {
    return WelcomeDrawerDataUpload(
      welcomeImageBase64: map['welcomeImageBase64'],
      welcomeMessage: map['welcomeMessage'],
      drawerBannerBase64: map['drawerBannerBase64'],
      drawerAboutUs: map['drawerAboutUs'],
      drawerService: map['drawerService'],
      drawerContacts: map['drawerContacts'],
      drawerCatalogue: map['drawerCatalogue'],
      drawerFaqs: map['drawerFaqs'],
    );
  }
}

class HomeSplash extends StatefulWidget {
  const HomeSplash({super.key});

  @override
  State<HomeSplash> createState() => _HomeSplashState();
}

class _HomeSplashState extends State<HomeSplash> {
  WelcomeDrawerDataUpload? _data;
  bool _hasConnection = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isConnected = connectivityResult != ConnectivityResult.none;

    if (!isConnected) {
      setState(() => _hasConnection = false);
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('welcome_drawer_data')
          .orderBy('welcomeMessage', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _data =
              WelcomeDrawerDataUpload.fromFirestore(snapshot.docs.first.data());
        });
      }
    } catch (e) {
      // Optionally log error or ignore silently
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: const Duration(seconds: 4),
      nextScreen: const MyApp(),
      backgroundColor: Colors.white,
      splashScreenBody: _buildSplashContent(),
    );
  }

  Widget _buildSplashContent() {
    if (!_hasConnection) {
      return const Center(
        child: Text(
          "You're offline",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    if (_data == null) {
      return const SizedBox(); // No loading UI, keep it blank
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_data!.welcomeImageBase64 != null)
          Image.memory(base64Decode(_data!.welcomeImageBase64!), height: 200),
        const SizedBox(height: 20),
        if (_data!.welcomeMessage != null)
          Text(
            _data!.welcomeMessage!,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'techforce.co.ke',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: AnyDrawerRouterDelegate(
        builder: (context) => const MyHomePage(title: 'Techforce'),
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
        if (!route.didPop(result)) return false;
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
  DrawerConfig config = const DrawerConfig(side: DrawerSide.left);
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
      onClose: () => debugPrint('Drawer closed'),
      onOpen: () => debugPrint('Drawer opened'),
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A0E21), Color(0xFF0A0E21), Color(0xFF1E3C72)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: _showDrawer,
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Homepagedisplay(),
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  Future<WelcomeDrawerDataUpload?> _fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('welcome_drawer_data')
        .orderBy('welcomeMessage', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return WelcomeDrawerDataUpload.fromFirestore(snapshot.docs.first.data());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WelcomeDrawerDataUpload?>(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done ||
            !snapshot.hasData) {
          return const SizedBox(); // Silently ignore loading here too
        }

        final data = snapshot.data!;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            children: [
              if (data.drawerBannerBase64 != null)
                Container(
                  height: 150,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Image.memory(base64Decode(data.drawerBannerBase64!),
                      fit: BoxFit.cover),
                ),
              if (data.drawerAboutUs != null)
                _drawerItem('About Us', data.drawerAboutUs!),
              if (data.drawerService != null)
                _drawerItem('Services', data.drawerService!),
              if (data.drawerContacts != null)
                _drawerItem('Contacts', data.drawerContacts!),
              if (data.drawerCatalogue != null)
                _drawerItem('Catalogue', data.drawerCatalogue!),
              if (data.drawerFaqs != null)
                _drawerItem('FAQs', data.drawerFaqs!),
            ],
          ),
        );
      },
    );
  }

  Widget _drawerItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(content,
              style: const TextStyle(fontSize: 14, color: Colors.white70)),
          const Divider(color: Colors.white30),
        ],
      ),
    );
  }
}
