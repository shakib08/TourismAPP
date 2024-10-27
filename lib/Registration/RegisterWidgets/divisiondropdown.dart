import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuition_media/Registration/controller/registrationcontroller.dart';

class DivisionDropdown extends StatelessWidget {
  const DivisionDropdown({Key? key}) : super(key: key);

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
          return DropdownButton<String>(
            value: controller.selectedDivision.value,
            isExpanded: true,
            underline: const SizedBox(),
            hint: const Text("Select Division"),
            items: controller.divisionDistrictMap.keys.map((String division) {
              return DropdownMenuItem<String>(
                value: division,
                child: Text(division),
              );
            }).toList(),
            onChanged: controller.updateDivision,
          );
        }),
      ),
    );
  }
}
