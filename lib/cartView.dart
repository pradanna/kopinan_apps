import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Components/cartItem.dart';
import 'Components/helper.dart';
import 'apiRequest/apiServices.dart';
import 'controller/cartController.dart';

class CartView extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Text('Keranjang Anda kosong'),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  var item = controller.cartItems[index];
                  return CartItem(
                    imageUrl: baseURL + item['image'],
                    name: item['barangs']['name'],
                    qty: item['qty'],
                    total: formatRupiah(item['price'] * item['qty']), onRemove: () {
                    controller.removeItemFromCart(item['id']);
                  },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() =>
                      Text(
                        'Total Harga: '+ formatRupiah(controller.totalPrice.value),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Logic for placing the order goes here
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Apakah pesanan sudah sesuai, dan yakin akan di checkout ?'),
                              actions: [
                                TextButton(
                                  child: Text('Batal'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    controller.checkout();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue,
                      ),
                      child: Text('Pesan Sekarang'),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
