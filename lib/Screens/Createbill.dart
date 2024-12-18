import 'package:billapp/Controller/Bill_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateBill extends StatelessWidget {
  CreateBill({super.key});
  //CUSTOMER DETAILS
  final _cusName = TextEditingController();
  final _conNo = TextEditingController();

//PRODUCT DETAILS
  final _itemName = TextEditingController();
  final _quantity = TextEditingController();
  final _unit = TextEditingController();
  final currentDate = DateFormat('dd/MM/yyy').format(DateTime.now());

  //################  CONTROLLER
  final BillController controller = Get.put(BillController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.shade600,
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.grey.shade700,
        title: const Text(
          "Create Bill",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(2.5),
        children: [
          const SizedBox(height: 10),
          //////////////////////////////////
          Container(
            height: 45,
            color: Colors.grey.shade200,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Customer Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 5),
            child: TextField(
              controller: _cusName,
              decoration: InputDecoration(
                labelText: "Customer Name",
                hintText: "Enter Customer Name",
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ),
          /////
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 6),
            child: TextField(
              controller: _conNo,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Contact Number",
                hintText: "Enter Contact Number",
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ////////////////////
          Container(
            height: 45,
            color: Colors.grey.shade200,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Products Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ////////////////////////////###@@@@@
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "   Product Name :-",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 6),
                  child: TextField(
                    controller: _itemName,
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                      hintText: "Enter Item Name",
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
              )
            ],
          ),
          ////////////////////
          Row(
            children: [
              const Text(
                "   Quantity :-          ",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 6),
                  child: TextField(
                    controller: _quantity,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                      // labelText: "",
                      filled: true,
                      hintText: "Enter Quantity",

                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
              )
            ],
          ),
          ///////////////
          Row(
            children: [
              const Text(
                "   Rate / Unit :-      ",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 6),
                  child: TextField(
                    controller: _unit,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                      hintText: "Enter Price",
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              final name = _itemName.text.trim();
              final quantity = int.tryParse(_quantity.text.trim()) ?? 0;
              final unitPrice = double.tryParse(_unit.text.trim()) ?? 0.0;

              if (name.isNotEmpty && quantity > 0 && unitPrice > 0) {
                controller.additem(name, quantity, unitPrice);
                _itemName.clear();
                _quantity.clear();
                _unit.clear();
                Get.snackbar(
                  "Success",
                  "Item added successfully",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              } else {
                Get.snackbar(
                  "Error",
                  "Please fill all fields correctly",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            child: const Text(
              "Add More Item",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),

          /////////////////////////////////////////
          // const SizedBox(height: 10),
          // ????????????????
          Obx(() {
            final items = Get.find<BillController>().items;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(
                    '${item['name']}',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  subtitle: Text('Qnty X Rate :- ${item['quantity']} ${" x "} ${item['unitPrice']}'),

                  trailing: Text(
                    textAlign: TextAlign.justify,
                    'Total :- ₹${item['total'].toStringAsFixed(2)}/-',
                    style: TextStyle(fontSize: 16),
                  ),
                  // trailing: text,
                );
              },
            );
          }),
          SizedBox(height: 10),
          ////////////////////////////////////
          Container(
            height: 35,
            color: const Color.fromARGB(175, 0, 0, 0),
            child: Padding(
              padding: EdgeInsets.only(left: 12, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount :- ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Obx(
                    () => Text(
                      "₹${controller.getAmount().toStringAsFixed(2)}/-",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          /////////////////////////////////////////
          ElevatedButton(
            onPressed: () {
              final per_name = _cusName.text;
              final number = int.tryParse(_conNo.text) ?? 0;

              controller.saveBill(per_name, number);
            },
            child: Text(
              "Save Bill",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 42, 141, 45),
            ),
          )
        ],
      ),
    );
  }
}
