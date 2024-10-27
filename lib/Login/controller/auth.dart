import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuition_media/Login/controller/logincontroller.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to login user
  Future<void> login(LoginController controller, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: controller.emailController.text,
        password: controller.passwordController.text,
      );

      // If the login is successful, check for admin credentials
      if (userCredential.user != null) {
        if (controller.emailController.text == 'admin@gmail.com' &&
            controller.passwordController.text == 'shakib') {
          context.go('/admin');
        } else {
          context.go('/home');
        }
      } else {
        // Show error if something went wrong
        _showError(context, "Login failed. Please try again.");
      }
    } on FirebaseAuthException catch (e) {
      // Handle different Firebase exceptions
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found for that email.";
          break;
        case 'wrong-password':
          errorMessage = "Wrong password provided.";
          break;
        default:
          errorMessage = "An error occurred. Please try again.";
      }
      _showError(context, errorMessage);
    }
  }

  // Helper function to show error messages
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
