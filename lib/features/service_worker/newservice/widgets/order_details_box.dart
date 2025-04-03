import 'package:flutter/material.dart';
import '../../../../core/models/order_model.dart';
import 'info_row.dart';

class OrderDetailsBox extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsBox({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
            InfoRow(icon: Icons.receipt_long, label: "Order ID", value: order.orderNumber),
            InfoRow(icon: Icons.person, label: "Customer", value: order.customerName),
            InfoRow(icon: Icons.priority_high, label: "Priority", value: order.priority),
            InfoRow(icon: Icons.timer, label: "Start Time", value: order.startTime),
            InfoRow(icon: Icons.timer_off, label: "End Time", value: order.endTime),
            InfoRow(icon: Icons.phone, label: "Phone", value: order.phoneNumber),
            InfoRow(icon: Icons.location_on, label: "Address", value: order.address),
          ],
        ),
      ),
    );
  }
}
