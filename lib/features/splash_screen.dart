import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/providers/auth_provider.dart';
import 'auth/screens/login_page.dart';
import 'piping_worker/piping_orders.dart';
import 'service_worker/servicespage/screens/services_page.dart';





class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), _navigateToNextScreen);
  }

  Future<void> _navigateToNextScreen() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadUserSession();

    if (authProvider.isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  authProvider.userRole == "service_worker"
                      ? const ServicesPage()
                      : const PipingOrders(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset(
          'lib/images/logo.png',
          width: 150,
          height: 150,
        ), // Adjust the path as needed
      ),
    );
  }
}
