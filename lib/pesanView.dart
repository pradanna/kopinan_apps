import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopinan_spps/controller/pesanController.dart';

class Pesanview extends StatelessWidget {
  final PesanController controller = Get.put(PesanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          // Profile Section
          Container(
            padding: EdgeInsets.all(16),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama: ${controller.userName.value}', style: TextStyle(fontSize: 20)),
                  Text('Nomor HP: ${controller.phoneNumber.value}', style: TextStyle(fontSize: 16)),
                ],
              );
            }),
          ),
          // Categories Section
          Container(
            height: 50,
            child: Obx(() {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.selectedCategory.value = index;
                    },
                    child: Obx(() {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        margin: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          color: controller.selectedCategory.value == index ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            controller.categories[index],
                            style: TextStyle(color: controller.selectedCategory.value == index ? Colors.white : Colors.black),
                          ),
                        ),
                      );
                    }),
                  );
                },
              );
            }),
          ),
          // Items Section
          Expanded(
            child: Obx(() {
              var selectedCategory = controller.categories[controller.selectedCategory.value];
              var items = controller.items[selectedCategory]!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        controller.addToCart(items[index]);
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: Obx(() {
        return FloatingActionButton(
          onPressed: () {
            Get.toNamed('/cart');
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.shopping_cart),
              if (controller.cartItemsCount.value > 0)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${controller.cartItemsCount.value}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
            // Home already selected
              break;
            case 1:
              Get.toNamed('/history');
              break;
            case 2:
              Get.toNamed('/account');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
