import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuition_media/Registration/controller/registrationcontroller.dart'; // Import the controller

class OccupationDropdown extends StatelessWidget {
  const OccupationDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegistrationController controller = Get.find();

    // List of occupations
    final List<String> occupations = [
      "Service Holder",
      "Business Man",
      "Government Employee",
      "Student",
      "Others"
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Rounded corners
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          return DropdownButton<String>(
            value:
                controller.selectedOccupation.value, // Observe the occupation
            isExpanded: true,
            underline: const SizedBox(), // No underline
            hint: const Text("Select Occupation"),
            items: occupations.map((String occupation) {
              return DropdownMenuItem<String>(
                value: occupation,
                child: Text(occupation),
              );
            }).toList(),
            onChanged: (String? value) {
              controller
                  .updateOccupation(value); // Update occupation in controller
            },
          );
        }),
      ),
    );
  }
}
