import 'package:flutter/material.dart';
import '../../../../core/models/order_model.dart';
import '../../newservice/screens/OrderProcessing.dart';
import '../widgets/order_detail_row.dart';
import '../widgets/order_checkbox.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;
  final bool changeMeter;
  final bool newMeter;

  const OrderDetailsPage({
    super.key,
    required this.order,
    required this.changeMeter,
    required this.newMeter,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    double screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Service Order Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Details Box
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Number (Big & Left Aligned)
                    Text(
                      "Order ID: ${order.orderNumber}",
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    // Remaining Order Details
                    OrderDetailRow(label: "Priority", value: order.priority),
                    OrderDetailRow(label: "Start Time", value: order.startTime),
                    OrderDetailRow(label: "End Time", value: order.endTime),
                    OrderDetailRow(
                      label: "Customer",
                      value: order.customerName,
                    ),
                    OrderDetailRow(label: "Phone", value: order.phoneNumber),
                    OrderDetailRow(label: "Address", value: order.address),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Service Order Remarks Box
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Service Order Remarks",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      controller: TextEditingController(
                        text: order.customerName,
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Checkboxes
              OrderCheckbox(label: "Change Meter", value: changeMeter),
              OrderCheckbox(label: "New Meter", value: newMeter),

              SizedBox(height: screenHeight * 0.03),

              // Responsive Start Work Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: screenWidth * 0.8, // 80% of screen width
                    height: screenHeight * 0.07, // 7% of screen height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => OrderProcessingPage(
                                  order: order,
                                  changeMeter: changeMeter,
                                  newMeter: newMeter,
                                ),
                          ),
                        );
                      },
                      child: Text(
                        "Start Work",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
