class OrderModel {
  final String orderNumber;
  final String priority;
  final String startTime;
  final String endTime;
  final String customerName;
  final String phoneNumber;
  final String remarks;
  final String address;

  OrderModel({
    required this.orderNumber,
    required this.priority,
    required this.startTime,
    required this.endTime,
    required this.customerName,
    required this.phoneNumber,
    required this.remarks,
    required this.address,
  });

  // Factory Constructor to create an OrderModel from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderNumber: json['orderNumber'] is String ? json['orderNumber'] : "Unknown", 
      priority: json['priority'] is String ? json['priority'] : "Normal",
      startTime: json['startTime'] is String ? json['startTime'] : "00:00 AM",
      endTime: json['endTime'] is String ? json['endTime'] : "00:00 AM",
      customerName: json['customerName'] is String ? json['customerName'] : "Unknown",
      phoneNumber: json['phoneNumber'] is String ? json['phoneNumber'] : "0000000000",
      address: json['address'] is String ? json['address'] : "No Address",
      remarks: json['remarks'] is String ? json['remarks'] : "No remarks", // Handle null for remarks
    );
  }
}
