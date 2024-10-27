import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  var profileImageUrl = ''.obs;
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var district = ''.obs;
  var division = ''.obs;
  var address = ''.obs;
  var occupation = ''.obs;
  var institution = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  void fetchUserInfo() async {
    try {
      // Get the currently logged-in user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userEmail = user.email ?? ''; // Get the user's email

        // Fetch user data from Firestore based on the email
        var userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          var userData = userSnapshot.docs.first.data();

          profileImageUrl.value = userData['profile_image_url'] ?? '';
          name.value = userData['name'] ?? '';
          email.value = userData['email'] ?? '';
          phone.value = userData['phone'] ?? '';
          district.value = userData['district'] ?? '';
          division.value = userData['division'] ?? '';
          address.value = userData['address'] ?? '';
          occupation.value = userData['occupation'] ?? '';
          institution.value = userData['institution'] ?? '';
        }
      } else {
        // Handle the case where no user is logged in
        Get.snackbar("Error", "No user is logged in.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user data: $e");
    }
  }
}
