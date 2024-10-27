import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tuition_media/Registration/controller/registrationcontroller.dart';


class DateOfBirthPicker extends StatelessWidget {
  const DateOfBirthPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegistrationController controller = Get.find();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
        child: ListTile(
          leading: const Icon(Icons.cake), // Birthday icon
          title: Obx(() {
            return Text(
              controller.selectedDateOfBirth.value != null
                  ? DateFormat('yyyy-MM-dd').format(controller.selectedDateOfBirth.value!)
                  : 'Select Date of Birth',
              style: TextStyle(
                fontSize: 16,
                color: controller.selectedDateOfBirth.value != null
                    ? Colors.black
                    : Colors.grey,
              ),
            );
          }),
          onTap: () {
            // Open the custom date picker when tapped
            _selectDate(context, controller);
          },
        ),
      ),
    );
  }

  // Function to show the date picker with efficient year selection
  Future<void> _selectDate(BuildContext context, RegistrationController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // Set the initial date to a neutral value, or use DateTime.now()
      firstDate: DateTime(1900), // Earliest selectable date
      lastDate: DateTime.now(), // Latest selectable date is today
      helpText: 'Select Date of Birth', // Help text shown above the calendar
      fieldLabelText: 'Date of Birth', // Label for the input field
      initialDatePickerMode: DatePickerMode.year, // Start with the year picker
    );

    if (picked != null && picked != controller.selectedDateOfBirth.value) {
      controller.updateDateOfBirth(picked); // Update the controller with the selected date
    }
  }
}
