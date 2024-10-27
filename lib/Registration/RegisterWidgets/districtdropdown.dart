import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuition_media/Registration/controller/registrationcontroller.dart';// Import the controller

class DistrictDropdown extends StatelessWidget {
  const DistrictDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegistrationController controller = Get.find();

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
          // Get the list of districts based on the selected division
          List<String> districts = controller.getDistricts();

          return DropdownButton<String>(
            value: controller.selectedDistrict.value,
            isExpanded: true,
            underline: const SizedBox(),
            hint: const Text("Select District"),
            items: districts.map((String district) {
              return DropdownMenuItem<String>(
                value: district,
                child: Text(district),
              );
            }).toList(),
            onChanged: controller.updateDistrict,
          );
        }),
      ),
    );
  }
}
