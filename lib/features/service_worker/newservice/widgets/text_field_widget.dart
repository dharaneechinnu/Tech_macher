import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String initialValue;

  const TextFieldWidget({super.key, required this.label, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            controller: TextEditingController(text: initialValue),
          ),
        ],
      ),
    );
  }
}
