import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:group6/presentation/auth/splashScreen.dart';

import 'package:group6/presentation/home/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is ready
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      ),
      home: SplashScreen()
    );
  }
}
 