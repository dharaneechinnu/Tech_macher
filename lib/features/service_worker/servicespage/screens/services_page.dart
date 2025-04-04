import 'package:app2/core/providers/auth_provider.dart';
import 'package:app2/core/providers/order_provider.dart';
import 'package:app2/features/auth/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../newservice/screens/new_service_orders.dart';
import '../../ongoingorder/screens/ongoing_orders.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  String servicemanName = '';
  String servicemanCode = '';

  void _logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    Hive.box('userBox').clear(); // Clear local storage on logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    final userBox = Hive.box('userBox');
    servicemanName = userBox.get('servicemanName', defaultValue: 'Serviceman');
    servicemanCode = userBox.get('servicemanCode', defaultValue: '');
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat(
      'EEEE, MMMM dd, yyyy',
    ).format(DateTime.now());

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              accountName: Text(
                servicemanName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: const Text(""),
              currentAccountPicture: const CircleAvatar(),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.black, size: 30),
              title: const Text("Profile", style: TextStyle(fontSize: 18)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 30,
              ),
              title: const Text("Settings", style: TextStyle(fontSize: 18)),
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red, size: 30),
                title: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                onTap: () => _logout(context),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              servicemanName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Service Code: $servicemanCode',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            Text(
              currentDate,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    buildTab("New Service Orders", 0),
                    buildTab("Ongoing", 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                Provider.of<OrderProvider>(
                  context,
                  listen: false,
                ).updateSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: "Search by Order Number or Customer Name",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  _selectedTab == 0
                      ? const NewServiceOrders()
                      : const OngoingOrders(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTab(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _selectedTab == index ? Colors.white : Colors.blue,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _selectedTab == index ? Colors.blue : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
