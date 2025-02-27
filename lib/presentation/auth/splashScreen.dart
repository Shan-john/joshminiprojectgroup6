import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group6/presentation/auth/login.dart';
import 'package:group6/presentation/auth/signUP.dart';
import 'package:group6/presentation/core.dart';
import 'package:group6/presentation/home/home.dart';
 
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading time
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Custom background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to My App!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.accentColor)),
          ],
        ),
      ),
    );
  }
}
