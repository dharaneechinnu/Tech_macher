import 'package:flutter/material.dart';

class OtherServicesPage extends StatelessWidget {
  const OtherServicesPage({super.key});

  final List<String> services = const [
    "Full system inspection required",
    "Vaporizer malfunction",
    "Gas supply issue",
    "Stove malfunction",
    "Manifold service",
    "Piping system service",
    "Regulator malfunction",
    "Pilot light malfunction",
    "Stove replacement required",
    "Rice cooker malfunction",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // This helps prevent overflow
        children: [
          const Text(
            "Select Other Services:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // ListView instead of Expanded with ListView.builder
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling of this list
            shrinkWrap: true, // Important! Allows list to take only needed space
            itemCount: services.length,
            itemBuilder: (context, index) {
              final isOthers = index == services.length - 1;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${index + 1}. ",
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        TextSpan(
                          text: services[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: isOthers ? Colors.blue : Colors.black,
                            decoration: isOthers ? TextDecoration.underline : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: const Icon(Icons.add_circle_outline, color: Colors.blue),
                  onTap: () {
                    if (isOthers) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OtherServiceDetailsPage(),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OtherServiceDetailsPage extends StatelessWidget {
  const OtherServiceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Other Service Details"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const Center(child: Text("This is the Other Services Page")),
    );
  }
}