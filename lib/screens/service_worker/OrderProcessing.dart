import 'package:flutter/material.dart';
import '../../models/order_model.dart';

class OrderProcessingPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
          // Order Details Box
          _buildOrderDetailsBox(),

          // Expanded TabBarView
          Expanded(
            child: DefaultTabController(
              length: 3, // Three tabs
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: "Change Meter"),
                      Tab(text: "Other Services"),
                      Tab(text: "Return"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildChangeMeterView(), // Change Meter Tab
                        const Center(
                          child: Text("Other Services"),
                        ), // Other Services Tab
                        const Center(child: Text("Return")), // Return Tab
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

  /// Widget for Order Details Box
  Widget _buildOrderDetailsBox() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID
            Row(
              children: [
                const Icon(Icons.receipt_long, color: Colors.blue),
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    children: [
                      const TextSpan(
                        text: "Order ID: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: order.orderNumber,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Customer Name
            _buildInfoRow(Icons.person, "Customer", order.customerName),

            // Priority
            _buildInfoRow(Icons.priority_high, "Priority", order.priority),

            // Start & End Time
            _buildInfoRow(Icons.timer, "Start Time", order.startTime),
            _buildInfoRow(Icons.timer_off, "End Time", order.endTime),

            // Phone Number
            _buildInfoRow(Icons.phone, "Phone", order.phoneNumber),

            // Address
            _buildInfoRow(Icons.location_on, "Address", order.address),
          ],
        ),
      ),
    );
  }

  /// Reusable Row Widget for displaying order details
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Widget for Change Meter / New Meter Details
  Widget _buildChangeMeterView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Service order list",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),

          // Show old meter details if changeMeter is true
          if (changeMeter) ...[
            _buildDetailRow("Old Meter ID (Serial num)", "<TEST1401>"),
            _buildDetailRow("Old Meter Item Code (SKU)", "< SKU >"),
            _buildTextField("Old Meter Reading", "00"),
          ],

          // New meter details
          _buildTextField("New Meter ID", ""),
          _buildTextField("New Meter Reading", "00"),

          const SizedBox(height: 20),

          // Preview Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                // Handle Preview Action
              },
              child: const Text(
                "Preview",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget to create a labeled row
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          Text(value, style: const TextStyle(fontSize: 18, color: Colors.blue)),
        ],
      ),
    );
  }

  /// Widget to create a text field
  Widget _buildTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            controller: TextEditingController(text: initialValue),
          ),
        ],
      ),
    );
  }
}
