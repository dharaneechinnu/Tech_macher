import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/order_model.dart';
import '../../../../core/providers/inventory_provider.dart';
import '../widgets/order_details_box.dart';
import '../widgets/change_meter_view.dart';
import '../widgets/new_meter_view.dart';
import '../widgets/preview_button.dart';
import 'OtherServicesPage.dart';
import 'ReturnPage.dart';

class OrderProcessingPage extends StatefulWidget {
  final CustomerServiceOrder order;
  final bool changeMeter;
  final bool newMeter;

  const OrderProcessingPage({
    super.key,
    required this.order,
    required this.changeMeter,
    required this.newMeter,
  });

  @override
  _OrderProcessingPageState createState() => _OrderProcessingPageState();
}

class _OrderProcessingPageState extends State<OrderProcessingPage> {
  @override
  Widget build(BuildContext context) {
    final inventoryProvider = Provider.of<InventoryProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Service Order Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              // Order Details Box
              OrderDetailsBox(order: widget.order),
              
              const SizedBox(height: 8),
              
              // Tab Bar
              Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  tabs: [
                    Tab(
                      text: widget.changeMeter ? "Change Meter" : "New Meter",
                    ),
                    const Tab(text: "Other Services"),
                    const Tab(text: "Return"),
                  ],
                ),
              ),
              
              // Tab Content
              Expanded(
                child: TabBarView(
                  children: [
                    // First Tab - Meter Service
                    _buildTabContent(
                      widget.changeMeter
                          ? const ChangeMeterView()
                          : const NewMeterView(),
                    ),
                    
                    // Second Tab - Other Services
                    _buildTabContent(const OtherServicesPage()),
                    
                    // Third Tab - Return
                    _buildTabContent(const ReturnPage()),
                  ],
                ),
              ),
              
              // Preview Button - Fixed at bottom
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: PreviewButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}