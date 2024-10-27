import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ConfirmTourController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isBookingConfirmed = false.obs;

  // Function to fetch the current user's data from Firestore using their email
  Future<Map<String, dynamic>?> getCurrentUserDataByEmail() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String email = currentUser.email!;

        // Query the 'users' collection to find the document with the current user's email
        QuerySnapshot userSnapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1) // Assuming email is unique, fetch only one result
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          return userSnapshot.docs.first.data() as Map<String, dynamic>;
        }
      }
    } catch (e) {
      print('Error fetching current user data by email: $e');
    }
    return null;
  }

  // Function to store the confirmed tour data into Firestore
  Future<void> confirmTour(
      String tourUid,
      String tourTitle,
      String payment,
      String tourcoverurl) async {
    try {
      // Get the current user's data by email
      Map<String, dynamic>? userData = await getCurrentUserDataByEmail();

      if (userData != null) {

        Map<String, dynamic> confirmTourData = {
          'name': userData['name'],
          'email': userData['email'],
          'profile_image_url': userData['profile_image_url'],
          'phone': userData['phone'],
          'tour_uid': tourUid,
          'tourtitle': tourTitle,
          'tourcoverimage': tourcoverurl,
          'payment': payment,
          'confirmed_at':
              Timestamp.now(),
        };


        await _firestore.collection('confirmtour').add(confirmTourData);

        print('Tour confirmed and saved to Firestore!');
      } else {
        print('Failed to fetch user data.');
      }
    } catch (e) {
      print('Error confirming the tour: $e');
    }
  }


  Future<void> checkBookingStatus(String tourUid) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null && currentUser.email != null) {
        String email = currentUser.email!;


        QuerySnapshot bookingSnapshot = await _firestore
            .collection('confirmtour')
            .where('tour_uid', isEqualTo: tourUid)
            .where('email', isEqualTo: email)
            .limit(1)
            .get();


        if (bookingSnapshot.docs.isNotEmpty) {
          isBookingConfirmed.value = true;
          print('Booking already confirmed for this tour.');
        } else {
          isBookingConfirmed.value = false;
        }
      }
    } catch (e) {
      print('Error checking booking status: $e');
    }
  }
}
