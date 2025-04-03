import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart'; // Now this file exists!
import '../../features/service_worker/servicespage/screens/services_page.dart';
import '../../features/piping_worker/piping_orders.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? role = Provider.of<AuthProvider>(context).userRole;

    if (role == "service_worker") {
      return ServicesPage();
    } else if (role == "piping_worker") {
      return PipingOrders();
    } else {
      return Scaffold(body: Center(child: Text("Unauthorized")));
    }
  }
}
