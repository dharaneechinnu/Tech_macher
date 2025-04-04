class CustomerServiceOrder {
  final String docNo;
  final String documentDate;
  final String priorityLevel;
  final String customerNo;
  final String contactNo;
  final String customerAddress2;
  final String customerAddress;
  final String customerName;
  final String description;
  final String serviceStatus;

  CustomerServiceOrder({
    required this.docNo,
    required this.documentDate,
    required this.priorityLevel,
    required this.customerNo,
    required this.contactNo,
    required this.customerAddress2,
    required this.customerAddress,
    required this.customerName,
    required this.description,
    required this.serviceStatus,
  });

  factory CustomerServiceOrder.fromJson(Map<String, dynamic> json) {
    return CustomerServiceOrder(
      docNo: json['doc_no'] ?? '',
      documentDate: json['document_date'] ?? '',
      priorityLevel: json['priority_level'] ?? '',
      customerNo: json['customer_no'] ?? '',
      contactNo: json['contact_no'] ?? '',
      customerAddress2: json['customer_address_2'] ?? '',
      customerAddress: json['customer_address'] ?? '',
      customerName: json['customer_name'] ?? '',
      description: json['description'] ?? '',
      serviceStatus: json['service_status'] ?? '',
    );
  }

  bool get isNew => serviceStatus.trim().isEmpty;
  bool get isOngoing => serviceStatus.trim().isNotEmpty;
}
