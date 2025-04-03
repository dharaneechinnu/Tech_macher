class InventoryItem {
  final String id;
  final String name;
  final String sku;
  int quantity;

  InventoryItem({
    required this.id,
    required this.name,
    required this.sku,
    required this.quantity,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'].toString(),
      name: json['name'].toString(),
      sku: json['sku'].toString(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'quantity': quantity,
    };
  }
}
