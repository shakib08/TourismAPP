import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'createcontroller.dart'; // Import the CreateTourController

class TourStorageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Function to store tour information in Firestore
  Future<void> saveTour(CreateTourController createTourController) async {
    try {
      // Upload the image to Firebase Storage and get the download URL
      String coverUrl = await uploadImage(createTourController.selectedImagePath.value);

      // Generate a new document reference with an automatically generated ID
      DocumentReference tourDocRef = _firestore.collection('tours').doc();
      String tourId = tourDocRef.id; // This is the automatically generated UID

      // Create a map of tour data, including the generated UID
      Map<String, dynamic> tourData = {
        'uid': tourId, // Store the generated UID in the document
        'startDate': createTourController.startDate.value,
        'endDate': createTourController.endDate.value,
        'price': createTourController.price.text,
        'title': createTourController.title.text,
        'description': createTourController.description.text,
        'cover_url': coverUrl, // Use the URL from Firebase Storage
      };

      // Add a new document to the "tours" collection with the generated UID
      await tourDocRef.set(tourData);

      // Optionally, you can show a success message or perform other actions
      Get.snackbar('Success', 'Tour saved successfully!');
    } catch (e) {
      // Handle errors, such as network issues or permission errors
      Get.snackbar('Error', 'Failed to save tour: $e');
    }
  }

  // Helper method to upload the image and return its download URL
  Future<String> uploadImage(String filePath) async {
    if (filePath.isEmpty) {
      throw Exception("No image selected");
    }

    // Create a reference to the storage location
    Reference storageRef = _storage.ref().child('tour_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

    // Upload the file
    UploadTask uploadTask = storageRef.putFile(File(filePath));

    // Wait for the upload to complete and get the download URL
    TaskSnapshot snapshot = await uploadTask;

    // Return the download URL
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

