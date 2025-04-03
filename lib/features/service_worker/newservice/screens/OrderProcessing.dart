import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/order_model.dart';
import '../../../../core/providers/inventory_provider.dart';
import '../widgets/order_details_box.dart';
import '../widgets/inventory_popup.dart';
import 'OtherServicesPage.dart';
import 'ReturnPage.dart';

class OrderProcessingPage extends StatefulWidget {
  final OrderModel order;
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
      body: Column(
        children: [
          OrderDetailsBox(order: widget.order), // ✅ Order Details Section
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: "Meter Service"),
                      Tab(text: "Other Services"),
                      Tab(text: "Return"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        widget.changeMeter
                            ? _buildChangeMeterView()
                            : _buildNewMeterView(),
                        OtherServicesPage(),
                        ReturnPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Change Meter UI
  Widget _buildChangeMeterView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildDetailRow("Old Meter ID (Serial num)", "TEST1401"),
          _buildDetailRow("Old Meter Item code (SKU)", " SKU "),
          _buildTextField("Old Meter Reading", "00"),
          const SizedBox(height: 10),
          _buildNewMeterSection(),
          _buildTextField("New Meter Reading", "00"),
          const SizedBox(height: 20),
          _buildPreviewButton(),
        ],
      ),
    );
  }

  // ✅ New Meter UI
  Widget _buildNewMeterView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNewMeterSection(),
          _buildTextField("New Meter Reading", "00"),
          const SizedBox(height: 20),
          _buildPreviewButton(),
        ],
      ),
    );
  }

  // ✅ Common UI for New Meter ID with Add Button
  Widget _buildNewMeterSection() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "New Meter ID",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const InventoryPopup(),
            );
          },
        ),
      ],
    );
  }

  // ✅ Common UI for Text Fields
  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // ✅ Common UI for Detail Rows (Old Meter ID, SKU, etc.)
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.blue),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Preview Button
  Widget _buildPreviewButton() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            // Add functionality for preview
          },
          child: const Text(
            "Preview",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
