import 'package:flutter/material.dart';
import 'detail_row.dart';
import 'text_field_widget.dart';
import 'new_meter_section.dart';
import 'preview_button.dart';

class ChangeMeterView extends StatelessWidget {
  const ChangeMeterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 10),
          DetailRow(label: "Old Meter ID (Serial num)", value: "TEST1401"),
          DetailRow(label: "Old Meter Item code (SKU)", value: "SKU"),
          TextFieldWidget(label: "Old Meter Reading", hint: "00"),
          SizedBox(height: 10),
          NewMeterSection(),
          TextFieldWidget(label: "New Meter Reading", hint: "00"),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
