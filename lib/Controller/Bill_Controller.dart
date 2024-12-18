import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BillController extends GetxController {
  var items = <Map<String, dynamic>>[].obs;
  var bills = <Bill>[].obs;
  var details = <Map<String, dynamic>>[].obs;
  var billDetails = <Bill, Map<String, dynamic>>{}.obs; // Map bills to details
  var billItems = <Bill, List<Map<String, dynamic>>>{}.obs; // Map bills to item

  // add user details
  void adddetails(String per_name, int number) {
    details.add({
      "per_name": per_name,
      "number": number,
    });
  }

  /// adding items
  void additem(String name, int quantity, double unitPrice) {
    items.add({
      "name": name,
      "quantity": quantity,
      "unitPrice": unitPrice,
      "total": quantity * unitPrice,
    });
  }

  double getAmount() {
    return items.fold(0.0, (sum, item) => sum + item["total"]);
  }

  void saveBill(String per_name, int number) {
    final totalAmount = getAmount();
    if (totalAmount <= 0) {
      Get.snackbar(
        "Error",
        "Total amount cannot be zero or empty. Please add items to the bill.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (items.isEmpty) {
      Get.snackbar(
        "Error",
        "No items added to the bill!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (per_name.isEmpty || number == 0) {
      Get.snackbar(
        "Error",
        "User details are incomplete!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    final date = DateFormat('dd/MM/yyyy').format(DateTime.now()); // Get current date
    final status = 'PAID';

    // Create the bill
    final bill = Bill(date: date, totalAmount: totalAmount, status: status);
    bills.add(bill);

    // Associate the bill with its details and items
    billDetails[bill] = {
      "per_name": per_name,
      "number": number
    };
    billItems[bill] = List<Map<String, dynamic>>.from(items);

    // bills.add(Bill(
    //   date: date,
    //   totalAmount: totalAmount,
    //   status: status,
    // ));

    // user details
    details.add({
      "per_name": per_name,
      "number": number,
    });

    items.clear();
    details.clear();
    Get.back();

    Get.snackbar(
      "Success",
      "Bill saved successfully",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}

class Bill {
  final String date;
  final double totalAmount;
  final String status;

  Bill({required this.date, required this.totalAmount, required this.status});
}
