import 'dart:convert';
import 'package:anydrawer/anydrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toptech/stateTv/homepage_displayTv.dart';
import 'package:toptech/stateTv/privacy_policyTv.dart';
import 'firebase_options.dart';

// --- ROUTE DEFINITIONS ---
class AppPaths {
  static const String home = '/';
  static const String privacy = '/privacy';
}
// -------------------------

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// Data model for Firestore data.
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

// The root of your application, configured to use the custom router.
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
      routerDelegate: AppRouterDelegate(),
      routeInformationParser: AppRouteInformationParser(),
    );
  }
}

// --- PWA ROUTING LOGIC ---

class AppRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) async {
    return routeInformation.location ?? AppPaths.home;
  }

  @override
  RouteInformation? restoreRouteInformation(String configuration) {
    return RouteInformation(location: configuration);
  }
}

class AppRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  String _currentPath = AppPaths.home;

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  String? get currentConfiguration => _currentPath;

  @override
  Future<void> setNewRoutePath(String configuration) async {
    _currentPath = configuration;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    if (_currentPath == AppPaths.privacy) {
      currentPage = const PrivacyAndPolicy();
    } else {
      currentPage = const Homepagedisplay();
    }

    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey(_currentPath),
          child: AppShell(
            child: currentPage,
          ),
        ),
      ],
      onPopPage: (route, result) {
        if (_currentPath != AppPaths.home) {
          setNewRoutePath(AppPaths.home);
          return true;
        }
        return false;
      },
    );
  }
}
// ---------------------------

/// AppShell provides the consistent background, AppBar, and Material context
/// for all pages within the app.
class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({super.key, required this.child});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final AnyDrawerController controller = AnyDrawerController();

  void _showDrawer() {
    showDrawer(
      context,
      builder: (context) => DrawerContent(controller: controller),
      config: const DrawerConfig(side: DrawerSide.left),
      controller: controller,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: _showDrawer,
            ),
          ),
        ),
        body: widget.child,
      ),
    );
  }
}

// The content of your slide-out drawer.
class DrawerContent extends StatelessWidget {
  final AnyDrawerController controller;
  const DrawerContent({super.key, required this.controller});

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
        if (snapshot.connectionState != ConnectionState.done || !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
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
                _drawerItem(context, 'About Us', data.drawerAboutUs!),
              if (data.drawerService != null)
                _drawerItem(context, 'Services', data.drawerService!),
              if (data.drawerContacts != null)
                _drawerItem(context, 'Contacts', data.drawerContacts!),
              if (data.drawerCatalogue != null)
                _drawerItem(context, 'Catalogue', data.drawerCatalogue!),
              if (data.drawerFaqs != null) _drawerItem(context, 'FAQs', data.drawerFaqs!),
              const Divider(color: Colors.white30, height: 20),
              _privacyPolicyLink(context),
            ],
          ),
        );
      },
    );
  }

  Widget _drawerItem(BuildContext context, String title, String content) {
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

  // Click handler that closes the drawer and navigates correctly.
  Widget _privacyPolicyLink(BuildContext context) {
    return InkWell(
      onTap: () {
        // Use the controller to close the drawer.
        controller.close();

        // Find the router delegate and tell it to navigate to the new path.
        (Router.of(context).routerDelegate as AppRouterDelegate)
            .setNewRoutePath(AppPaths.privacy);
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(Icons.shield_outlined, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
