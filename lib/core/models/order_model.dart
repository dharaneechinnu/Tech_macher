class OrderModel {
  final String orderNumber;
  final String priority;
  final String startTime;
  final String endTime;
  final String customerName;
  final String phoneNumber;
  final String address;

  OrderModel({
    required this.orderNumber,
    required this.priority,
    required this.startTime,
    required this.endTime,
    required this.customerName,
    required this.phoneNumber,
    required this.address,
  });

  // Factory Constructor to create an OrderModel from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderNumber: json['orderNumber']?.toString() ?? "Unknown", // Ensure String
      priority: json['priority']?.toString() ?? "Normal",
      startTime: json['startTime']?.toString() ?? "00:00 AM",
      endTime: json['endTime']?.toString() ?? "00:00 AM",
      customerName: json['customerName']?.toString() ?? "Unknown",
      phoneNumber: json['phoneNumber']?.toString() ?? "0000000000",
      address: json['address']?.toString() ?? "No Address",
    );
  }
}
