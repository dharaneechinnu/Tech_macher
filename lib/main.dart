import 'package:app2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:app2/screens/auth/login_page.dart';
import 'package:app2/screens/service_worker/services_page.dart';
import 'package:provider/provider.dart';
import 'package:app2/providers/order_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()), // ✅ Add this line
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Service App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // Set initial route
      routes: {
        '/': (context) => const LoginPage(),
        '/services': (context) => const ServicesPage(), // Named route for Services Page
      },
    );
  }
}
