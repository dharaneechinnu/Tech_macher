import 'package:flutter/material.dart';
import 'new_meter_section.dart';
import 'text_field_widget.dart';
import 'preview_button.dart';

class NewMeterView extends StatelessWidget {
  const NewMeterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          NewMeterSection(),
          TextFieldWidget(label: "New Meter Reading", hint: "00"),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
