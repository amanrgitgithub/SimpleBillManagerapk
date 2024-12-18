import 'package:billapp/Controller/Bill_Controller.dart';
import 'package:billapp/Screens/Createbill.dart';
import 'package:billapp/Screens/View_Bill.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final BillController controller = Get.put(BillController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(124, 0, 0, 0),
        elevation: 5,
        shadowColor: Colors.grey.shade300,
        title: const Text(
          "Bill Records",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.bills.isEmpty) {
          return Center(
            child: Text(
              "No bills saved yet",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.bills.length,
          itemBuilder: (context, index) {
            final bill = controller.bills[index];
            final userDetails = controller.billDetails[bill] ??
                {
                  "per_name": "Unknown",
                  "number": 0
                }; // Fetch user details
            final products = controller.billItems[bill] ?? []; // Fetch items

            return GestureDetector(
              onTap: () {
                Get.to(() => ViewBills(
                      bill: bill,
                      userDetails: userDetails,
                      products: products,
                    ));
              },
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    height: 70,
                    color: Colors.grey.shade200,
                    child: ListTile(
                      title: Text(
                        bill.date,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Total : ₹ ${bill.totalAmount.toStringAsFixed(2)}/-"),
                      trailing: Text(
                        bill.status,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 19, 156, 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 67, 207, 45),
        ),
        onPressed: () {
          Get.to(() => CreateBill());
        },
        child: const Text(
          "Add New Bill",
          style: TextStyle(height: 2, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
