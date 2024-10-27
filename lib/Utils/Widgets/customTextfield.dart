import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextInputType inputType;
  final TextEditingController controller; // New parameter for TextEditingController

  const CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.inputType,
    required this.controller, // Required controller parameter
  });

  @override
  Widget build(BuildContext context) {
    // Getting the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: screenWidth * 0.9, // 90% of screen width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Rounded corners
          color: Colors.white, // Background color
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // Changes position of shadow
            ),
          ],
        ),
        child: TextField(
          controller: controller, // Use the controller here
          keyboardType: inputType, // Set input type based on parameter
          decoration: InputDecoration(
            prefixIcon: Icon(icon), // Display the icon passed as parameter
            labelText: label, // Display the label passed as parameter
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20), // Match the shape
              borderSide: BorderSide.none, // No border
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
