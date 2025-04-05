import 'package:flutter/material.dart';

class PreviewButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PreviewButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50, // Fixed height to avoid layout issues
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed ?? () {
          // Default Preview action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Preview clicked')),
          );
        },
        child: const Text(
          "Preview",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}