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
                  _buildHeader(context),
                  const Divider(),
                  _buildTableHeader(),
                  const SizedBox(height: 8),
                  _buildInventoryList(inventoryProvider, context),
                  const SizedBox(height: 16),
                  _buildAddInventoryButton(context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// ✅ **Build Header with Close Button**
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Inventory in Vehicle",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  /// ✅ **Build Table Header**
  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
    );
  }

  /// ✅ **Build Inventory List with Scrollable Area**
  Widget _buildInventoryList(
    InventoryProvider inventoryProvider,
    BuildContext context,
  ) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: inventoryProvider.inventory.length,
        itemBuilder: (context, index) {
          final item = inventoryProvider.inventory[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            child: Row(
              children: [
                _buildItemDetails(item),
                _buildAvailableQuantity(item),
                _buildUsedQuantityControls(item, inventoryProvider, context),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ✅ **Build Item Details with SKU and Name**
  Widget _buildItemDetails(item) {
    return Expanded(
      flex: 6,
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.inventory, size: 14),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  item.sku,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ **Build Available Quantity**
  Widget _buildAvailableQuantity(item) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Text(
          "${item.availableQuantity}",
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }

  /// ✅ **Build Used Quantity Controls**
  Widget _buildUsedQuantityControls(
    item,
    InventoryProvider inventoryProvider,
    BuildContext context,
  ) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildQuantityButton(
            Icons.remove_circle_outline,
            item.usedQuantity > 0,
            () {
              inventoryProvider.updateUsedQuantity(
                item.id,
                item.usedQuantity - 1,
              );
              inventoryProvider.setSelectedItem(item.id, item.sku);
            },
          ),
          SizedBox(
            width: 24,
            child: Text(
              "${item.usedQuantity}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          _buildQuantityButton(
            Icons.add_circle_outline,
            item.usedQuantity < item.availableQuantity,
            () {
              inventoryProvider.updateUsedQuantity(
                item.id,
                item.usedQuantity + 1,
              );
              inventoryProvider.setSelectedItem(item.id, item.sku);
            },
          ),
        ],
      ),
    );
  }

  /// ✅ **Build Quantity Buttons**
  Widget _buildQuantityButton(
    IconData icon,
    bool isEnabled,
    VoidCallback onPressed,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: isEnabled ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            icon,
            size: 16,
            color: isEnabled ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }

  /// ✅ **Build Add Inventory Button**
  Widget _buildAddInventoryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          "Add Inventory to Work",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
