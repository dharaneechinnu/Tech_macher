class InventoryItem {
  final String id;
  final String name;
  final String sku;
  int availableQuantity; // Tracks stock available in vehicle
  int usedQuantity; // Tracks how many are used

  InventoryItem({
    required this.id,
    required this.name,
    required this.sku,
    required this.availableQuantity,
    this.usedQuantity = 0, // Default to 0 if not provided
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'].toString(),
      name: json['name'].toString(),
      sku: json['sku'].toString(),
      availableQuantity: (json['availableQuantity'] as int?) ?? 0, // ✅ Prevents null error
      usedQuantity: (json['usedQuantity'] as int?) ?? 0, // ✅ Prevents null error
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'availableQuantity': availableQuantity,
      'usedQuantity': usedQuantity,
    };
  }
}
