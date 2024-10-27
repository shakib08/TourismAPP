import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuition_media/Registration/controller/registrationcontroller.dart';
import 'package:tuition_media/Utils/Widgets/loading.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reference to Firebase Storage for image uploads (if required)
  final FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  // Function to save user registration data to Firestore
  Future<void> saveUserData(RegistrationController controller, BuildContext context) async {
    try {
      showLoadingDialog(context);
      String? imageUrl;

      // If an image was selected, upload it to Firebase Storage first
      if (controller.selectedImagePath.value.isNotEmpty) {
        imageUrl =
            await _uploadImageToStorage(controller.selectedImagePath.value);
      }

      // Prepare user data for Firestore
      Map<String, dynamic> userData = {
        'name': controller.nameController.text,
        'email': controller.emailController.text,
        'phone': controller.phoneController.text,
        'institution': controller.institutionController.text,
        'address': controller.presentAddressController.text,
        'occupation': controller.selectedOccupation.value,
        'division': controller.selectedDivision.value,
        'district': controller.selectedDistrict.value,
        'password': controller.passwordController.text,
        'date_of_birth':
            controller.selectedDateOfBirth.value?.toIso8601String(),
        'profile_image_url': imageUrl, // Image URL from Firebase Storage
      };

      // Add the user data to Firestore in the "users" collection
      await _firestore.collection('users').add(userData);
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: controller.emailController.text,
        password: controller.passwordController.text,
      );
      print('User data successfully saved to Firestore.');
      context.go('/login');
    } catch (e) {
      print('Error saving user data: $e');
      rethrow; // Rethrow the error to be handled by the caller
    }
  }

  // Function to upload image to Firebase Storage and return the download URL
  Future<String> _uploadImageToStorage(String imagePath) async {
    try {
      // Create a reference to a location in Firebase Storage
      Reference ref = _storage
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the image
      UploadTask uploadTask = ref.putFile(File(imagePath));

      // Wait for the upload to complete and get the download URL
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }
}
