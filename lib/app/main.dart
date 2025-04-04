import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 👈 Add this

import 'package:app2/core/providers/auth_provider.dart';
import 'package:app2/core/providers/inventory_provider.dart';
import 'package:app2/core/providers/order_provider.dart';
import 'package:app2/features/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🧪 Load .env file
  await dotenv.load(fileName: ".env"); // 👈 Load environment variables

  // 🔐 Initialize Hive
  await Hive.initFlutter();

  // 📦 Open boxes
  await Hive.openBox('authBox');
  await Hive.openBox('userBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => InventoryProvider()),
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
