import 'package:flutter/material.dart';
import 'inventory_popup.dart';

class NewMeterSection extends StatelessWidget {
  const NewMeterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "New Meter ID",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const InventoryPopup(),
            );
          },
        ),
      ],
    );
  }
}
