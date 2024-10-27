import 'package:flutter/material.dart';

class LargeTextField extends StatelessWidget {
  final String hintText;
  final double width;
  final TextEditingController controller;
  final TextInputType inputType;

  const LargeTextField({
    Key? key,
    required this.hintText,
    required this.width,
    required this.controller,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: MediaQuery.of(context).size.height * 0.4, // 40% of the screen height
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        maxLines: null, // Allows the text to expand within the text field
        expands: true, // Expands the text field to fill its parent height
        textAlignVertical: TextAlignVertical.top, // Aligns text to the top of the text field
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
