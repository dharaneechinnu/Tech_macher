import 'package:app2/core/models/inventory_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/order_model.dart';
import '../../../../core/providers/inventory_provider.dart';
import '../widgets/order_details_box.dart';
import '../widgets/inventory_popup.dart';
import 'OtherServicesPage.dart';
import 'ReturnPage.dart';

class OrderProcessingPage extends StatefulWidget {
  final OrderModel order;
  final bool changeMeter;
  final bool newMeter;

  const OrderProcessingPage({
    super.key,
    required this.order,
    required this.changeMeter,
    required this.newMeter,
  });

  @override
  _OrderProcessingPageState createState() => _OrderProcessingPageState();
}

class _OrderProcessingPageState extends State<OrderProcessingPage> {
  String? selectedItemId;
  String? selectedItemSKU;

  void _updateSelectedItem(String itemId, String itemSKU) {
    setState(() {
      selectedItemId = itemId;
      selectedItemSKU = itemSKU;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inventoryProvider = Provider.of<InventoryProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Service Order Details",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          OrderDetailsBox(order: widget.order),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TabBar(
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 3.0, color: Colors.blue),
                      ),
                      tabs: const [
                        Tab(text: "Meter Service"),
                        Tab(text: "Other Services"),
                        Tab(text: "Return"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        widget.changeMeter
                            ? _buildChangeMeterView()
                            : _buildNewMeterView(),
                        OtherServicesPage(),
                        ReturnPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeMeterView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Old Meter ID (Serial num)", "TEST1401"),
          _buildDetailRow("Old Meter Item code (SKU)", "SKU"),
          _buildTextField("Old Meter Reading", "00"),
          _buildNewMeterSection(),
          _buildTextField("New Meter Reading", "00"),
          const SizedBox(height: 16),
          _buildPreviewButton(),
        ],
      ),
    );
  }

  Widget _buildNewMeterView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNewMeterSection(),
          _buildTextField("New Meter Reading", "00"),
          const SizedBox(height: 16),
          _buildPreviewButton(),
        ],
      ),
    );
  }

  Widget _buildNewMeterSection() {
    return Consumer<InventoryProvider>(
      builder: (context, inventoryProvider, child) {
        List<InventoryItem> usedItems = inventoryProvider.selectedItems;

        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "New Meter ID",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    usedItems.isNotEmpty ? usedItems.first.id : "Not Selected",
                    style: const TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "New Meter SKU",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    usedItems.isNotEmpty ? usedItems.first.sku : "Not Selected",
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.blue,
                size: 20,
              ),
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (context) => InventoryPopup(),
                );
                if (result != null && result is Map<String, String>) {
                  inventoryProvider.addToSelectedItems(result['itemId']!);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, color: Colors.blue),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () {},
        child: const Text(
          "Preview",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
