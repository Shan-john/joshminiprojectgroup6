import 'package:flutter/material.dart';
import 'package:group6/presentation/auth/login.dart';
import 'package:group6/presentation/core.dart';
import 'package:group6/presentation/home/home.dart';
import 'package:group6/service/firebaseService.dart';
 
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("Sign Up", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var user = await signUpWithEmail(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        fullNameController.text.trim(),
                      );
                      if (user != null) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CurtainControlPage()));
                      }
                    }
                  },
                  child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
