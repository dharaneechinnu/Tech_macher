import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/order_provider.dart';

class OngoingOrders extends StatelessWidget {
  const OngoingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).ongoingOrders;

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Header (Number + Priority)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order #${order.orderNumber}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    _priorityBadge(order.priority),
                  ],
                ),

                const SizedBox(height: 12),

                // Order Timing
                _iconText(Icons.access_time, "Start: ${order.startTime}"),
                _iconText(Icons.access_time, "End: ${order.endTime}"),

                const SizedBox(height: 10),
                const Divider(height: 1, thickness: 1),

                const SizedBox(height: 10),

                // Customer Details
                _iconText(Icons.person, order.customerName),
                _iconText(Icons.phone, order.phoneNumber),
                _iconText(Icons.location_on, order.address),
              ],
            ),
          ),
        );
      },
    );
  }

  // Reusable Widget for Icon + Text
  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  // Priority Badge with Color Coding
  Widget _priorityBadge(String priority) {
    Color priorityColor;
    switch (priority.toLowerCase()) {
      case 'urgent':
        priorityColor = Colors.red;
        break;
      case 'low':
        priorityColor = Colors.green;
        break;
      default:
        priorityColor = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: priorityColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: priorityColor,
        ),
      ),
    );
  }
}
