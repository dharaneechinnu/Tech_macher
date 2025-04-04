import 'package:flutter/material.dart';
import '../models/inventory_model.dart';

class InventoryProvider with ChangeNotifier {
  // Sample inventory data
  final List<InventoryItem> _inventory = [
    InventoryItem(id: '1', name: 'Regulator', sku: '12131', availableQuantity: 2),
    InventoryItem(id: '2', name: 'New Meter', sku: 'Z131', availableQuantity: 1),
    InventoryItem(id: '3', name: 'Vaporiser', sku: '12131', availableQuantity: 1),
    InventoryItem(id: '4', name: 'L-Joint', sku: 'LJ-001', availableQuantity: 1),
    InventoryItem(id: '5', name: 'Stove Knob', sku: 'SK-101', availableQuantity: 1),
    InventoryItem(id: '6', name: 'Regulator Old', sku: 'RO-303', availableQuantity: 1),
  ];

  final List<InventoryItem> _selectedItems = [];

  List<InventoryItem> get inventory => List.unmodifiable(_inventory);
  List<InventoryItem> get selectedItems => List.unmodifiable(_selectedItems);

  // Simulate API call with delay
  Future<void> fetchInventory() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulated network delay
    notifyListeners();
  }

  // ✅ Update available quantity (ensuring it doesn't go negative)
  void updateQuantity(String itemId, int newQuantity) {
    int index = _inventory.indexWhere((item) => item.id == itemId);
    if (index != -1 && newQuantity >= 0) {
      _inventory[index].availableQuantity = newQuantity;
      notifyListeners();
    }
  }

  // ✅ Update used quantity
  void updateUsedQuantity(String itemId, int newUsedQuantity) {
    int index = _inventory.indexWhere((item) => item.id == itemId);
    if (index != -1 && newUsedQuantity >= 0 && newUsedQuantity <= _inventory[index].availableQuantity) {
      _inventory[index].usedQuantity = newUsedQuantity;
      notifyListeners();
    }
  }

  // ✅ Add item to selected list (tracks "used" items)
  void addToSelectedItems(String itemId) {
    int inventoryIndex = _inventory.indexWhere((item) => item.id == itemId);
    if (inventoryIndex == -1) return; // Item not found

    int selectedIndex = _selectedItems.indexWhere((item) => item.id == itemId);
    if (selectedIndex == -1) {
      _selectedItems.add(
        InventoryItem(
          id: _inventory[inventoryIndex].id,
          name: _inventory[inventoryIndex].name,
          sku: _inventory[inventoryIndex].sku,
          availableQuantity: _inventory[inventoryIndex].availableQuantity,
          usedQuantity: 1,
        ),
      );
    } else if (_selectedItems[selectedIndex].usedQuantity < _selectedItems[selectedIndex].availableQuantity) {
      _selectedItems[selectedIndex].usedQuantity += 1;
    }
    notifyListeners();
  }

  // ✅ Remove item from selected list
  void removeFromSelectedItems(String itemId) {
    _selectedItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }
  
 void setSelectedItem(String itemId, String sku) {
  _selectedItems.clear(); // If only one item should be selected
  _selectedItems.add(InventoryItem(id: itemId, sku: sku, name: '', availableQuantity: 0, usedQuantity: 0));
  notifyListeners();
}


}
