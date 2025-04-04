import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app2/core/providers/inventory_provider.dart';

class InventoryPopup extends StatelessWidget {
  const InventoryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<InventoryProvider>(
            builder: (context, inventoryProvider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Inventory in Vehicle",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const Divider(),

                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "SKU List",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "Qty in Veh",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              "Qty Used",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Inventory List with Scrollable Area
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: inventoryProvider.inventory.length,
                      itemBuilder: (context, index) {
                        final item = inventoryProvider.inventory[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 4.0,
                          ),
                          child: Row(
                            children: [
                              // SKU and Name
                              Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    // Optional: Image or Icon
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.grey[200],
                                      child: const Icon(
                                        Icons.inventory,
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Text content
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            item.sku,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Available Quantity
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    "${item.availableQuantity}",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),

                              // Used Quantity Controls - Optimized for space
                              Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Minus button - More compact
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        customBorder: const CircleBorder(),
                                        onTap:
                                            item.usedQuantity > 0
                                                ? () => inventoryProvider
                                                    .updateUsedQuantity(
                                                      item.id,
                                                      item.usedQuantity - 1,
                                                    )
                                                : null,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.remove_circle_outline,
                                            size: 16,
                                            color:
                                                item.usedQuantity > 0
                                                    ? Colors.blue
                                                    : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Quantity display
                                    SizedBox(
                                      width: 24,
                                      child: Text(
                                        "${item.usedQuantity}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    // Plus button - More compact
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        customBorder: const CircleBorder(),
                                        onTap:
                                            item.usedQuantity <
                                                    item.availableQuantity
                                                ? () => inventoryProvider
                                                    .updateUsedQuantity(
                                                      item.id,
                                                      item.usedQuantity + 1,
                                                    )
                                                : null,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            size: 16,
                                            color:
                                                item.usedQuantity <
                                                        item.availableQuantity
                                                    ? Colors.blue
                                                    : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Add Inventory Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Add Inventory to Work",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
