import 'dart:ui' as ui;

import 'package:app/components/NavBar.dart';
import 'package:app/pages/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

bool debugEmulateFlutterTesterEnvironment = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  // Use the suggested replacement from dart:ui_web for setting debugEmulateFlutterTesterEnvironment
  debugEmulateFlutterTesterEnvironment = true;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: Colors.green.shade600,
          indicatorColor: Colors.green.shade300,
        ),
        appBarTheme: AppBarTheme(color: Colors.green.shade300),
        primaryColor: Colors.green,
        primaryIconTheme: IconThemeData(color: Colors.green),
      ),
      home: const NavBar(),
    );
  }
}
