import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TourBookedController extends GetxController {
  var tourList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserTours();
  }

  Future<void> fetchUserTours() async {
    try {
      // Get current user's email
      String userEmail = FirebaseAuth.instance.currentUser!.email!;
      print("Current User's Email: $userEmail");

      // Query Firestore collection 'confirmtour' where email matches current user
      var querySnapshot = await FirebaseFirestore.instance
          .collection('confirmtour')
          .where('email', isEqualTo: userEmail)
          .get();

      // Log the document count and each document's data
      print('Total Documents Found: ${querySnapshot.docs.length}');

      if (querySnapshot.docs.isNotEmpty) {
        tourList.value = querySnapshot.docs.map((doc) {
          print('Document Data: ${doc.data()}');  // Log full document data

          // Check if 'tourcoverimage' exists, otherwise handle the missing field
          return {
            'tour_uid': doc['tour_uid'],
            'tourcoverimage': doc.data().containsKey('tourcoverimage') && doc['tourcoverimage'] != null
                ? doc['tourcoverimage']
                : 'https://via.placeholder.com/200',  // Placeholder image if missing
            'tourtitle': doc['tourtitle'],
          };
        }).toList();
      } else {
        print("No matching tours found.");
      }
    } catch (e) {
      print('Error fetching tours: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
