import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  var profileImageUrl = ''.obs; // Observable to hold user's profile image URL
  var name = ''.obs; 

  @override
  void onInit() {
    super.onInit();
    _getUserProfileImage(); // Fetch image when the controller is initialized
  }

  // Function to get user's profile image from Firestore using email
  Future<void> _getUserProfileImage() async {
    User? user = FirebaseAuth.instance.currentUser; // Get current user
    if (user != null && user.email != null) {
      try {
        // Query Firestore to find the document by email
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: user.email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Assuming there is only one document with the user's email
          DocumentSnapshot userDoc = querySnapshot.docs.first;

          // Check if profile_image_url exists in the document
          profileImageUrl.value = userDoc['profile_image_url'] as String? ?? '';
          name.value = userDoc['name'] as String? ?? 'User'; // Fallback to 'User' if no name
          print("Image Fetched from the database Successfully");
        } else {
          print("No document found for the provided email.");
          profileImageUrl.value = ''; // Fallback to empty string
        }
      } catch (e) {
        print("Error fetching user profile: $e");
        profileImageUrl.value = ''; // Fallback in case of error
      }
    } else {
      print("No user is currently logged in or email is null.");
    }
  }
}
