import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Components/helper.dart';
import 'Components/menuItem.dart';
import 'apiRequest/apiServices.dart';
import 'controller/cartController.dart';

class MenuItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> menuItem;

  MenuItemDetailPage({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final qty = 1.obs;
    final note = ''.obs;
    final usePoints = false.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text(menuItem['name']),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar besar di atas
                  Image.network(
                    baseURL + menuItem['image'],
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  // Nama menu
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      menuItem['name'],
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Harga menu
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      formatRupiah(menuItem['price']),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.green),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Field untuk mengisi note
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      onChanged: (value) => note.value = value,
                      decoration: InputDecoration(
                        labelText: 'Note',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  // Radio button untuk memilih menggunakan point atau tidak
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("pembayaran Menggunakan Point ?")),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Obx(() => RadioListTile<bool>(
                          title: Text('Ya'),
                          value: true,
                          groupValue: usePoints.value,
                          onChanged: (value) {
                            if (value != null) {
                              usePoints.value = value;
                            }
                          },
                        )),
                        Obx(() => RadioListTile<bool>(
                          title: Text('Tidak'),
                          value: false,
                          groupValue: usePoints.value,
                          onChanged: (value) {
                            if (value != null) {
                              usePoints.value = value;
                            }
                          },
                        )),
                      ],
                    ),
                  ),
              
                ],
              ),
            ),
          ),

          SizedBox(height: 20),
          // Pengaturan quantity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

                  // Total belanja
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(() {
                      final total = qty.value * menuItem['price'];
                      return Text(
                        'Total: ${formatRupiah(total)}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      );
                    }),
                  ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [



                        SizedBox(width: 20),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (qty.value > 1) {
                              qty.value--;
                            }
                          },
                        ),
                        Obx(() => Text(qty.value.toString(), style: TextStyle(fontSize: 18))),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            qty.value++;
                          },
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Tombol untuk memasukkan ke keranjang
          Obx(() => cartController.isLoadingCart.value
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await cartController.addToCart(menuItem['id'], qty.value, note.value, true);
                  // Get.offAndToNamed("/home");
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  backgroundColor: Colors.lightBlue,
                ),
                child: Text('Add to Cart', style: TextStyle(fontSize: 18)),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
