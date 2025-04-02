import 'package:flutter/material.dart';
import '../../models/order_model.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Service Order Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Box with only Order Number
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ), // Light grey border
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "Order ID: ${order.orderNumber}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Other order details (outside the box)
            _buildDetailRow("Priority", order.priority),
            _buildDetailRow("Start Time", order.startTime),
            _buildDetailRow("End Time", order.endTime),
            _buildDetailRow("Customer", order.customerName),
            _buildDetailRow("Phone", order.phoneNumber),
            _buildDetailRow("Address", order.address),

            const SizedBox(height: 16),

            // Service Order Remarks
            const Text(
              "Service Order Remarks",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Changed color to blue
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter remarks here...",
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Checkbox for "New Meter"
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.blue, // Changed checkbox color to blue
                ),
                const Text("New Meter"),
              ],
            ),

            const Spacer(),

            // Start Work Button
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background blue
                    foregroundColor: Colors.white, // Text color white
                  ),
                  onPressed: () {
                    // Action for Start Work button
                  },
                  child: const Text(
                    "Start Work",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to create detail rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
