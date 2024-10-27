import 'package:flutter/material.dart';

class CustomGestureDetector extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onTap;

  const CustomGestureDetector({
    super.key,
    required this.text,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle the tap event
      child: Text(
        text,
        style: TextStyle(
          color: textColor, // Set the text color based on the parameter
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
