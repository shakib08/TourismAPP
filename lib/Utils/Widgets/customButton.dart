import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final double width;
  final VoidCallback onPressed; // Add a callback for button action

  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Set width based on the provided parameter
      height: 50, // Fixed height for the button
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Set background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
        ),
        onPressed: onPressed, // Button action
        child: Text(
          text,
          style: TextStyle(
            color: textColor, // Set text color
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
