import 'package:app2/core/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:app2/features/service_worker/orderdetails/screens/order_details_page.dart';

class NewServiceOrders extends StatefulWidget {
  const NewServiceOrders({super.key});

  @override
  State<NewServiceOrders> createState() => _NewServiceOrdersState();
}

class _NewServiceOrdersState extends State<NewServiceOrders> {
  @override
  void initState() {
    super.initState();
    Provider.of<CustomerServiceProvider>(
      context,
      listen: false,
    ).fetchServiceOrdersFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<CustomerServiceProvider>(context).newOrders;

    final userBox = Hive.box('userBox');
    final servicemanName = userBox.get(
      'servicemanName',
      defaultValue: 'Unknown',
    );
    final servicemanCode = userBox.get('servicemanCode', defaultValue: 'N/A');

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Orders List
          Expanded(
            child:
                orders.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => OrderDetailsPage(
                                      order: order,
                                      changeMeter: true,
                                      newMeter: false,
                                    ),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Order #${order.docNo}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      _priorityBadge(order.priorityLevel),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  _iconText(
                                    Icons.access_time,
                                    "Start: ${order.documentDate}",
                                  ),
                                  _iconText(
                                    Icons.access_time,
                                    "End: ${order.documentDate}",
                                  ),
                                  const SizedBox(height: 10),
                                  _iconText(Icons.person, order.customerName),
                                  _iconText(Icons.phone, order.contactNo),
                                  _iconText(
                                    Icons.location_on,
                                    order.customerAddress,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

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
