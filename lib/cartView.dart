import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Rp ${item['price']} x ${item['quantity']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_shopping_cart),
                      onPressed: () {
                        controller.removeFromCart(item['name']);
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Harga: Rp ${controller.totalPrice}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Logic for placing the order goes here
                        Get.snackbar('Order', 'Pesanan Anda berhasil dilakukan!');
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
