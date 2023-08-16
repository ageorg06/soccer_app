import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:next_gen_first_app/feautures/teams/teams_page.dart';
import 'package:next_gen_first_app/feautures/users/user_controller.dart';
import '../../core/services/auth_services.dart';
import '../users/user_page.dart';

class AuthRequestHandler {
  final Auth _auth = Auth();

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("Login successfully");
    } catch (e) {
      print("Error logging in: $e");  // Debugging print statement
      throw e;
    }
  }

  Future<void> signup(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("Signed up successfully");  // Debugging print statement
      
      // Create a new user document in Firestore
      FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'username': '',  // Empty for now, can be updated later
        'teamId': null,  // Null for now, can be updated later
      });
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserPage(userId: userCredential.user!.uid),
        ),
      );
    } catch (e) {
      print("Error signing up: $e");  // Debugging print statement
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("Signed out successfully");  // Debugging print statement
    } catch (e) {
      print("Error signing out: $e");  // Debugging print statement
      throw e;
    }
  }
}
