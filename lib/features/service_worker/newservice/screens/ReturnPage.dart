import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/inventory_provider.dart';

class ReturnPage extends StatelessWidget {
  const ReturnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryProvider>(
      builder: (context, inventoryProvider, _) {
        final inventory = inventoryProvider.inventory;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                "Return Inventory Items",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: inventory.length,
              itemBuilder: (context, index) {
                final item = inventory[index];
                final isSelected = inventoryProvider.selectedItems.any(
                  (selected) => selected.id == item.id,
                );

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                      "SKU: ${item.sku} | Available: ${item.availableQuantity}",
                    ),
                    trailing:
                        isSelected
                            ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                            : ElevatedButton(
                              onPressed: () {
                                inventoryProvider.addToSelectedItems(item.id);
                              },
                              child: const Text("Return"),
                            ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
