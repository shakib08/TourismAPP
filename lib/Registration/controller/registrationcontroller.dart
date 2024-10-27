import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationController extends GetxController {
  // TextEditingControllers for the form fields
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var institutionController = TextEditingController();
  var departmentController = TextEditingController();
  var resultController = TextEditingController();
  var presentAddressController = TextEditingController();
  var passwordController = TextEditingController();

  // Selected division, district, occupation, and date of birth
  var selectedDivision = Rxn<String>();
  var selectedDistrict = Rxn<String>();
  var selectedOccupation = Rxn<String>();
  var selectedDateOfBirth = Rxn<DateTime>(); // Manage Date of Birth

  // Selected image path
  var selectedImagePath = ''.obs; // This is the missing definition

  void updateDateOfBirth(DateTime value) {
    selectedDateOfBirth.value = value;
  }

  // Division-District mapping
  final Map<String, List<String>> divisionDistrictMap = {
    "Dhaka": [
      "Dhaka",
      "Gazipur",
      "Manikganj",
      "Munshiganj",
      "Narayanganj",
      "Tangail"
    ],
    "Chittagong": [
      "Chittagong",
      "Cox's Bazar",
      "Khagrachari",
      "Rangamati",
      "Bandarban"
    ],
    "Khulna": ["Khulna", "Jessore", "Satkhira", "Bagerhat", "Narail"],
    "Barisal": ["Barisal", "Patuakhali", "Pirojpur", "Bhola", "Jhalokathi"],
    "Rajshahi": ["Rajshahi", "Natore", "Pabna", "Naogaon", "Bogura"],
    "Sylhet": ["Sylhet", "Moulvibazar", "Habiganj", "Sunamganj"],
    "Rangpur": ["Rangpur", "Dinajpur", "Kurigram", "Gaibandha", "Panchagarh"],
    "Mymenshing": ["Mymensingh", "Netrokona", "Jamalpur", "Sherpur"],
  };

  // Function to update the selected division
  void updateDivision(String? value) {
    selectedDivision.value = value;
    selectedDistrict.value = null; // Reset district when division changes
  }

  // Function to update the selected district
  void updateDistrict(String? value) {
    selectedDistrict.value = value;
  }

  // Function to update the selected occupation
  void updateOccupation(String? value) {
    selectedOccupation.value = value;
  }

  // Get districts for the selected division
  List<String> getDistricts() {
    if (selectedDivision.value == null) {
      return [];
    }
    return divisionDistrictMap[selectedDivision.value!] ?? [];
  }

  // Function to pick an image using ImagePicker
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value =
          pickedFile.path; // Store the selected image path
    } else {
      selectedImagePath.value = ''; // No image selected
    }
  }
}
