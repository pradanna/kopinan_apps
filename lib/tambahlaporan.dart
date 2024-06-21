import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'Components/TakePhotoCard.dart';
import 'controller/ReportController.dart';
import 'controller/imagePickerController.dart';

class TambahLaporanView extends StatelessWidget {
  final ImagePickerController controller = Get.put(ImagePickerController());
  final ReportController reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    // Mengambil argumen menggunakan Get.parameters atau Get.arguments
    final arguments = Get.arguments as Map<String, dynamic>?;

    // Contoh mengambil nilai itemId
    final argtype = arguments?['type'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
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
                                        "Tambahkan Laporan",
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
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          "Ambil Foto Sesuai dengan Jenis Foto",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Takephotocard(
                          imagePreview: Obx(() => controller
                                      .selectedImagePath.value ==
                                  ''
                              ? Text('No image selected.')
                              : Image.file(
                                  File(controller.selectedImagePath.value))),
                          // Ganti dengan path gambar Anda
                          photoType: argtype,
                          onTakePhoto: () =>
                              controller.pickImage(ImageSource.camera),
                          SendData: () {
                            final type = argtype.toString();
                            final lat = "-7.546788418548";
                            final lng = "10.1618181681681";
                            final imagePath =
                                controller.selectedImagePath.value;
                            reportController.sendReport(
                                type, lat, lng, imagePath);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Center(child: Obx(() {
            if (reportController.isLoading.value) {
              return Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: reportController.uploadProgress.value,
                      semanticsLabel: 'Uploading',
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${(reportController.uploadProgress.value * 100).toStringAsFixed(0)}%',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }))
        ],
      ),
    );
  }
}
