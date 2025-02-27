import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group6/model/usermodel';
 
 
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Sign-Up Function (Saves User Data to Firestore)
Future<UserModel?> signUpWithEmail(String email, String password, String fullName) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    if (user != null) {
      UserModel newUser = UserModel(
        uid: user.uid,
        fullName: fullName,
        email: email,
        createdAt: DateTime.now(),
      );

      // Save User Data to Firestore
      await _firestore.collection("users").doc(user.uid).set(newUser.toMap());

      return newUser;
    }
    return null;
  } catch (e) {
    print("Sign-Up Error: $e");
    return null;
  }
}

// Fetch User Data from Firestore
Future<UserModel?> getUserData(String uid) async {
  try {
    DocumentSnapshot userDoc = await _firestore.collection("users").doc(uid).get();

    if (userDoc.exists) {
      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    }
  } catch (e) {
    print("Fetch User Error: $e");
  }
  return null;
}

// Login Function
Future<UserModel?> loginWithEmail(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    if (user != null) {
      return getUserData(user.uid); // Fetch user data on login
    }
    return null;
  } catch (e) {
    print("Login Error: $e");
    return null;
  }
}

// Logout Function
void logout() async {
  await _auth.signOut();
}
