import 'package:flutter/material.dart';
import 'detail_row.dart';
import 'text_field_widget.dart';

class ChangeMeterView extends StatelessWidget {
  final bool changeMeter;

  const ChangeMeterView({super.key, required this.changeMeter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Service order list",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),

          if (changeMeter) ...[
            DetailRow(label: "Old Meter ID (Serial num)", value: "<TEST1401>"),
            DetailRow(label: "Old Meter Item Code (SKU)", value: "< SKU >"),
            TextFieldWidget(label: "Old Meter Reading", initialValue: "00"),
          ],

          TextFieldWidget(label: "New Meter ID", initialValue: ""),
          TextFieldWidget(label: "New Meter Reading", initialValue: "00"),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                // Handle Preview Action
              },
              child: const Text(
                "Preview",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
