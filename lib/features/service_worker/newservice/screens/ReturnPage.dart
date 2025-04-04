import 'package:flutter/material.dart';

class ReturnPage extends StatelessWidget {
  const ReturnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Return")),
      body: const Center(child: Text("This is the Return Page")),
    );
  }
}
