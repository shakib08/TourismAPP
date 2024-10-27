import 'package:flutter/material.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final double width;
  final Color textColor;
  final VoidCallback onPressed;

  CustomButtonWithIcon({
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.width,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: textColor,
        ),
        label: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Rounded rectangle shape
          ),
          padding: EdgeInsets.symmetric(vertical: 12), // Vertical padding for better height
        ),
        onPressed: onPressed,
      ),
    );
  }
}
