import 'package:app2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
// Import Piping Page
import 'package:provider/provider.dart';
import 'package:app2/providers/order_provider.dart';
import './screens/splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter initializes before running

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
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
      home: const SplashScreen(),
    );
  }
}
