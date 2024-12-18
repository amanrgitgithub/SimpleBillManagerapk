import 'package:billapp/Controller/Bill_Controller.dart';
import 'package:flutter/material.dart';

class ViewBills extends StatelessWidget {
  final Bill bill;
  final Map<String, dynamic> userDetails;
  final List<Map<String, dynamic>> products;
  const ViewBills({
    super.key,
    required this.bill,
    required this.userDetails,
    required this.products,
  });

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey.shade600,
          shadowColor: Colors.grey.shade500,
          elevation: 5,
          title: const Text(
            "Bill Details",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
                width: double.infinity,
                color: Colors.grey.shade300,
                height: 40,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "  Customer Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name:- ${userDetails['per_name']}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Contact :- ${userDetails['number']}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              height: 40,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Text(
                "  Products ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
                child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(
                    product["name"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "Qnty ${product["quantity"]} X  Unit Price: ₹${product["unitPrice"].toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Text(
                    "₹${product["total"].toStringAsFixed(2)}/-",
                    style: TextStyle(fontSize: 18),
                  ),
                );
              },
            )),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                color: Colors.grey.shade200,
                width: double.infinity,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '  Total Amount:-',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '₹ ${bill.totalAmount.toStringAsFixed(2)}/-',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
