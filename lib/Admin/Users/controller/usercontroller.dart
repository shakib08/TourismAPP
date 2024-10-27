import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var users = <UserModel>[].obs; // Observable list to hold users

  @override
  void onInit() {
    fetchUsers(); // Fetch users when the controller is initialized
    super.onInit();
  }

  void fetchUsers() async {
    try {
      // Fetching users from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      users.value = querySnapshot.docs
          .map((doc) => UserModel.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching users: $e");
    }
  }
}

// User model to hold user data
class UserModel {
  final String name;
  final String phone;
  final String email; // Add email field
  final String profileImageUrl;
  final String division; // Add division field
  final String district; // Add district field
  final String address; // Add address field
  final String occupation; // Add occupation field
  final String institution; // Add institution field

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.profileImageUrl,
    required this.division,
    required this.district,
    required this.address,
    required this.occupation,
    required this.institution,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '', // Ensure the field is present in the Firestore document
      profileImageUrl: data['profile_image_url'] ?? '',
      division: data['division'] ?? '', // Ensure the field is present in the Firestore document
      district: data['district'] ?? '', // Ensure the field is present in the Firestore document
      address: data['address'] ?? '', // Ensure the field is present in the Firestore document
      occupation: data['occupation'] ?? '', // Ensure the field is present in the Firestore document
      institution: data['institution'] ?? '', // Ensure the field is present in the Firestore document
    );
  }
}

