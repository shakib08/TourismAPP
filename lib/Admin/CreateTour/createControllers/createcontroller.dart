import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateTourController extends GetxController {
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController title = TextEditingController();

  var selectedImagePath = ''.obs;

  void selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate.value) {
      startDate.value = picked;
    }
  }

  void selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate.value) {
      endDate.value = picked;
    }
  }

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
