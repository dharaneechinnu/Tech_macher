<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 👈 Add this

=======
>>>>>>> parent of 1ccf6b6 (Api intergration success in login and logout clear all session')
import 'package:app2/core/providers/auth_provider.dart';
import 'package:app2/core/providers/inventory_provider.dart';
import 'package:flutter/material.dart';
// Import Piping Page
import 'package:provider/provider.dart';
import 'package:app2/core/providers/order_provider.dart';
<<<<<<< HEAD
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
=======
import '../features/splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter initializes before running
>>>>>>> parent of 1ccf6b6 (Api intergration success in login and logout clear all session')

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
