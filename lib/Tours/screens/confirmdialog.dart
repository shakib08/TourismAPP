import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuition_media/Utils/Constant/colors.dart';

// A custom confirmation dialog widget
class ConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmation'),
      content: const Text('Do you want to confirm?'),
      actions: [
        // Cancel button
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            context.pop(); // Close the dialog
          },
        ),
        const Spacer(),
        // Confirm button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: customIndigoColor, // Set the background color to purple
          ),
          onPressed: () {
            onConfirm(); // Trigger the confirm action
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Confirm', style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
