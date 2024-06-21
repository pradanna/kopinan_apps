import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'controller/ReportController.dart';
import 'controller/imagePickerController.dart';

class ChooseReport extends StatelessWidget {
  final ImagePickerController controller = Get.put(ImagePickerController());
  final ReportController reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: 1.sh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    width: 1.sw,
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          height: 100,
                          width: 1.sh,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                image: AssetImage('assets/background.jpg'),
                                fit: BoxFit
                                    .cover, // Menyesuaikan ukuran gambar sesuai dengan ukuran container
                              )),
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
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                  Text(
                                    "Pilih Jenis Laporan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    padding: EdgeInsets.all(10),
                    width: 0.9.sw,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Pilih laporan yang akan anda buat",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              label: 'Speedometer',
                              imagePath: 'assets/speedo.jpg',
                              onPressed: () {
                                Get.toNamed('/tambahlaporan',
                                    arguments: {'type': 'Speedometer'});
                              },
                            ),
                            SizedBox(width: 20),
                            CustomButton(
                              label: 'Stiker Belakang',
                              imagePath: 'assets/stikerbelakang.jpg',
                              onPressed: () {
                                Get.toNamed('/tambahlaporan',
                                    arguments: {'type': 'Stiker Belakang'});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.9.sw,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Laporan hanya bisa dibuat dengan menggunakan foto atau kamera dari aplikasi ini dan jangan dipalsukan.',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomButton({
    required this.label,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Column(
          children: [
            Container(
              width: 0.3.sw,
              height: 0.3.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
