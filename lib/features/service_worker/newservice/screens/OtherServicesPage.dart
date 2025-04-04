import 'package:flutter/material.dart';

class OtherServicesPage extends StatelessWidget {
  const OtherServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Other Services")),
      body: const Center(child: Text("This is the Other Services Page")),
    );
  }
}
