import 'package:flutter/material.dart';
import '../models/inventory_model.dart';

class InventoryProvider with ChangeNotifier {
  // Sample inventory data
  List<InventoryItem> _inventory = [
    InventoryItem(id: '1', name: 'Regulator', sku: '12131', quantity: 2),
    InventoryItem(id: '2', name: 'New Meter', sku: 'Z131', quantity: 1),
    InventoryItem(id: '3', name: 'Vaporiser', sku: '12131', quantity: 1),
    InventoryItem(id: '4', name: 'L-Joint', sku: 'LJ-001', quantity: 1),
    InventoryItem(id: '5', name: 'Stove Knob', sku: 'SK-101', quantity: 1),
    InventoryItem(id: '6', name: 'Regulator Old', sku: 'RO-303', quantity: 1),
  ];

  List<InventoryItem> get inventory => _inventory;

  // Simulating API call by adding a delay
  Future<void> fetchInventory() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulated network delay
    notifyListeners();
  }

  // Update inventory item quantity
  void updateQuantity(String itemId, int newQuantity) {
    int index = _inventory.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _inventory[index].quantity = newQuantity;
      notifyListeners();
    }
  }
}
