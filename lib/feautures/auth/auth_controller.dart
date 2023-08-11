// auth_controller.dart

import 'auth_services.dart';

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

  Future<void> signup(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("Signed up successfully");  // Debugging print statement
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
