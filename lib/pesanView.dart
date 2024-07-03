import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kopinan_spps/Components/colorsMaster.dart';
import 'package:kopinan_spps/controller/cartController.dart';
import 'package:kopinan_spps/controller/pesanController.dart';

import 'Components/menuItem.dart';

class Pesanview extends StatelessWidget {
  final PesanController controller = Get.put(PesanController());
  final CartController  cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Container(
        color: Colorsmaster.backgroundColor,
        height: 1.sh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: .23.sh,
                    width: 1.sw,
                    child: Stack(
                      children: [
                        Container(
                            padding: EdgeInsets.all(16),
                            height: 250,
                            width: 1.sh,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/bg.jpg'),
                                  fit: BoxFit
                                      .cover, // Menyesuaikan ukuran gambar sesuai dengan ukuran container
                                )),
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text('Nama: ${controller.userName.value} ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                                              Text('Nomor HP: ${controller.phoneNumber.value}', style: TextStyle(fontSize: 12.sp, color: Colors.white)),

                                ],
                              ),
                            ),
                        Positioned(
                            top: 20,
                            child: Container(
                              padding: EdgeInsets.all(24),
                              width: 1.sw,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.asset('assets/images/logo.png')),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed("/profile");
                                    },
                                    child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Image.asset('assets/images/user.png')),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              // Text('Silahkan pesan menu dibawah.', style: TextStyle(color: Colorsmaster.defaultTextColor, fontWeight: FontWeight.bold), ),
              Container(
                height: .77.sh,
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
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
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                      margin: EdgeInsets.only(left: 8),
                                      decoration: BoxDecoration(
                                        color: controller.selectedCategory.value == index ? Colors.white : Colorsmaster.backgroundColor,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Text(
                                          controller.categories[index],
                                          style: TextStyle(color: controller.selectedCategory.value == index ? Colorsmaster.backgroundColor : Colors.white),
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
                                return  MenuItem(
                                  imageUrl: 'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/riaupos/4919-img_6848.jpeg',
                                  name: items[index],
                                  price: 25000,
                                  onAddToCart: (){ controller.addToCart(items[index]);
                                  cartController.addToCart(items[index], 25000);
                                  }
                                );
                              },
                            );
                          }),
                        ),
                  ],
                ),
              )
            ],
          ),
        ),
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
    );
  }
}
