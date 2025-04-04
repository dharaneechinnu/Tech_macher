import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:app2/core/models/order_model.dart';
import 'package:app2/core/services/network_services.dart';

class CustomerServiceProvider with ChangeNotifier {
  final Dio _dio = Dio();
  final NetworkService _networkService = NetworkService();

  List<CustomerServiceOrder> _newOrders = [];
  List<CustomerServiceOrder> _ongoingOrders = [];

  List<CustomerServiceOrder> get newOrders => _newOrders;
  List<CustomerServiceOrder> get ongoingOrders => _ongoingOrders;

  // 🔍 Search logic
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // 🔍 Filtered results
  List<CustomerServiceOrder> get filteredNewOrders {
    if (_searchQuery.isEmpty) return _newOrders;
    return _newOrders.where((order) => _matchesSearch(order)).toList();
  }

  List<CustomerServiceOrder> get filteredOngoingOrders {
    if (_searchQuery.isEmpty) return _ongoingOrders;
    return _ongoingOrders.where((order) => _matchesSearch(order)).toList();
  }

  bool _matchesSearch(CustomerServiceOrder order) {
    final query = _searchQuery.toLowerCase();
    return order.docNo.toLowerCase().contains(query) ||
        order.customerName.toLowerCase().contains(query) ||
        order.customerAddress.toLowerCase().contains(query) ||
        order.contactNo.toLowerCase().contains(query);
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners(); // 🔁 Refresh filtered results
  }

  // 📡 API call
  Future<void> fetchServiceOrdersFromAPI() async {
    final response = await _networkService.getServiceOrders();

    if (response == null || response.statusCode != 200) {
      print("❌ Failed to fetch service orders");
      return;
    }

    try {
      final jsonString = response.data['value'];
      final parsedJson = json.decode(jsonString);

      List orders = parsedJson['results']['serviceman']['service_orders'];

      _newOrders = [];
      _ongoingOrders = [];

      for (var order in orders) {
        if (order['type'] == 'Customer Service') {
          final parsed = CustomerServiceOrder.fromJson(order);

          if (parsed.isNew) {
            _newOrders.add(parsed);
          } else {
            _ongoingOrders.add(parsed);
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print("❗ Error parsing service orders: $e");
    }
  }
}
