import 'package:flutter/material.dart';
import '../models/order_model.dart';

class Order {
  final String orderNumber;
  final String priority;
  final String startTime;
  final String endTime;
  final String customerName;
  final String phoneNumber;
  final String address;
  final bool isOngoing; // Determines if it's ongoing or new

  Order({
    required this.orderNumber,
    required this.priority,
    required this.startTime,
    required this.endTime,
    required this.customerName,
    required this.phoneNumber,
    required this.address,
    required this.isOngoing,
  });
}

class OrderProvider with ChangeNotifier {
  final List<OrderModel> _newOrders = [
    OrderModel(
      orderNumber: "001",
      priority: "Urgent",
      startTime: "10:00 AM",
      endTime: "12:00 PM",
      customerName: "John Doe",
      phoneNumber: "9876543210",
      address: "123 Street, City",
    ),
    OrderModel(
      orderNumber: "002",
      priority: "Normal",
      startTime: "2:00 PM",
      endTime: "4:00 PM",
      customerName: "Jane Smith",
      phoneNumber: "8765432109",
      address: "456 Avenue, City",
    ),
  ];

  final List<OrderModel> _ongoingOrders = [
    OrderModel(
      orderNumber: "101",
      priority: "High",
      startTime: "9:00 AM",
      endTime: "11:00 AM",
      customerName: "Alice Johnson",
      phoneNumber: "7654321098",
      address: "789 Boulevard, City",
    ),
    OrderModel(
      orderNumber: "102",
      priority: "Medium",
      startTime: "3:00 PM",
      endTime: "5:00 PM",
      customerName: "Bob Williams",
      phoneNumber: "6543210987",
      address: "321 Lane, City",
    ),
  ];

  String _searchQuery = "";

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Order> get newServiceOrders =>
      _newOrders
          .where(
            (order) =>
                order.address.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                order.orderNumber.contains(_searchQuery),
          )
          .map(
            (order) => Order(
              orderNumber: order.orderNumber,
              priority: order.priority,
              startTime: order.startTime,
              endTime: order.endTime,
              customerName: order.customerName,
              phoneNumber: order.phoneNumber,
              address: order.address,
              isOngoing: false,
            ),
          )
          .toList();

  List<Order> get ongoingOrders =>
      _ongoingOrders
          .where(
            (order) =>
                order.address.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                order.orderNumber.contains(_searchQuery),
          )
          .map(
            (order) => Order(
              orderNumber: order.orderNumber,
              priority: order.priority,
              startTime: order.startTime,
              endTime: order.endTime,
              customerName: order.customerName,
              phoneNumber: order.phoneNumber,
              address: order.address,
              isOngoing: true,
            ),
          )
          .toList();
}
