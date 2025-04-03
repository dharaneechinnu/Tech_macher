import 'package:flutter/material.dart';

class OrderCheckbox extends StatelessWidget {
  final String label;
  final bool value;

  const OrderCheckbox({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Checkbox(
          value: value,
          onChanged: null,
          fillColor: WidgetStateProperty.resolveWith<Color>(
            (states) => value ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }
}
