import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TourController extends GetxController {
  // Observable list for storing tours
  var tours = <Map<String, dynamic>>[].obs;

  // Fetch tours from Firestore
  void fetchTours() {
    FirebaseFirestore.instance.collection('tours').snapshots().listen((snapshot) {
      tours.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  // Navigate to details screen using GoRouter
  void goToDetails(BuildContext context, Map<String, dynamic> tour) {
    // Use context.go to navigate in GoRouter
    context.go('/tour_details', extra: tour);
  }
}
