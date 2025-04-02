import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart'; // Now this file exists!
import '../screens/service_worker/services_page.dart';
import '../screens/piping_worker/piping_orders.dart';

class HomeScreen extends StatelessWidget {
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
