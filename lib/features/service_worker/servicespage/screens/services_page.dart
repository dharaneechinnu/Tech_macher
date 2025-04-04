import 'package:app2/core/providers/auth_provider.dart';
import 'package:app2/core/providers/order_provider.dart';
import 'package:app2/features/auth/screens/login_page.dart';
import 'package:app2/features/service_worker/newservice/screens/new_service_orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import '../../ongoingorder/screens/ongoing_orders.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  String servicemanName = 'Service Dashboard';
  String servicemanCode = '';

  void _logout(BuildContext context) async {
    await Provider.of<AuthProvider>(context, listen: false).logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    final userBox = Hive.box('userBox');
    setState(() {
      servicemanName = userBox.get('servicemanName') ?? 'Service Dashboard';
      servicemanCode = userBox.get('servicemanCode') ?? '';
    });
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
              accountName: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    servicemanName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(servicemanCode, style: const TextStyle(fontSize: 14)),
                ],
              ),
              accountEmail: null,
              currentAccountPicture: const CircleAvatar(),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.black, size: 30),
              title: const Text("Profile", style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 30,
              ),
              title: const Text("Settings", style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
              },
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Increased height
        child: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white, size: 32),
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      servicemanName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      servicemanCode,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      currentDate,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  _buildTabButton("New Service Orders", 0),
                  _buildTabButton("Ongoing", 1),
                ],
              ),
            ),
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
                Provider.of<CustomerServiceProvider>(
                  context,
                  listen: false,
                ).setSearchQuery(value);
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
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
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

  Widget _buildTabButton(String title, int index) {
    final bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          color: isSelected ? Colors.white : Colors.blue,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
