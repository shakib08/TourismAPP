import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tuition_media/Database/firebaseservice.dart';
import 'package:tuition_media/Registration/RegisterWidgets/divisiondropdown.dart';
import 'package:tuition_media/Registration/RegisterWidgets/districtdropdown.dart';
import 'package:tuition_media/Registration/RegisterWidgets/dobcalender.dart';
import 'package:tuition_media/Registration/RegisterWidgets/occupassiondropdown.dart';
import 'package:tuition_media/Registration/controller/registrationcontroller.dart';
import 'package:tuition_media/Utils/Widgets/customGestureDetector.dart';
import 'package:tuition_media/Utils/Constant/colors.dart';
import 'package:tuition_media/Utils/Widgets/customButton.dart';
import 'package:tuition_media/Utils/Widgets/customTextfield.dart'; // Import the controller

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistrationController controller = Get.put(RegistrationController());
    final FirebaseService firebaseService = FirebaseService();
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                    icon: Icons.person,
                    label: 'Name',
                    inputType: TextInputType.text,
                    controller: controller.nameController),
                CustomTextField(
                    icon: Icons.email,
                    label: 'Email',
                    inputType: TextInputType.text,
                    controller: controller.emailController),
                CustomTextField(
                    icon: Icons.phone,
                    label: 'Phone Number',
                    inputType: TextInputType.number,
                    controller: controller.phoneController),

                // Using Obx to reactively update the dropdown based on the controller's value
                DivisionDropdown(),
                DistrictDropdown(),
                CustomTextField(
                    icon: Icons.location_city,
                    label: "Address",
                    inputType: TextInputType.text,
                    controller: controller.presentAddressController),
                OccupationDropdown(),
                CustomTextField(
                    icon: Icons.work,
                    label: 'Institution',
                    inputType: TextInputType.text,
                    controller: controller.institutionController),
                DateOfBirthPicker(),
                CustomTextField(
                  icon: Icons.lock,
                  label: "Password",
                  inputType: TextInputType.visiblePassword,
                  controller: controller.passwordController,
                ),
                Container(
                  width: size.width * 0.9,
                  child: Row(
                    children: [
                      CustomButton(
                          backgroundColor: Colors.white,
                          text: "Picture",
                          textColor: customIndigoColor,
                          width: size.width * 0.9 * 0.4,
                          onPressed: controller.pickImage),

                      // Display the image file name
                      Obx(() {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              controller.selectedImagePath.value.isNotEmpty
                                  ? controller.selectedImagePath.value
                                      .split('/')
                                      .last // Extract file name from path
                                  : "No image selected", // Default text
                              style: TextStyle(
                                fontSize: 16,
                                color: controller
                                        .selectedImagePath.value.isNotEmpty
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              overflow:
                                  TextOverflow.ellipsis, // Truncate if too long
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                CustomButton(
                    backgroundColor: customIndigoColor,
                    text: "sign up",
                    textColor: Colors.white,
                    width: size.width * 0.9,
                    onPressed: () async {
                    try {
                      await firebaseService.saveUserData(controller, context); // Save user data to Firestore
                      print('Registration successful');
                    } catch (e) {
                      print('Error during registration: $e');
                      // Show an error message to the user
                    }
                  },),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Text("Already have an account?"),
                CustomGestureDetector(
                    text: "Login",
                    textColor: customIndigoColor,
                    onTap: () {
                      context.go('/login');
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
