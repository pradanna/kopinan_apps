import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kopinan_spps/controller/paymentController.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeController extends GetxController {
  var inputText = ''.obs;

  void updateText(String text) {
    inputText.value = text;
  }
}

class QrCodeView extends StatelessWidget {
  final QrCodeController controller = Get.put(QrCodeController());

  final Paymentcontroller pController = Get.put(Paymentcontroller());
  final id = Get.arguments['id'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengambilan Pesanan'),
      ),
      body: Container(
        width: 1.sw,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
            
              Obx(() => pController.isloading.value ? Center(child: CircularProgressIndicator(),) : SizedBox(height: 20)),
                pController.notrans == "123"
                   ? Container()
                  : QrImageView(
                  data: controller.inputText.value,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              SizedBox(height: 50),
              Text("Tunjukan QR ini ke kasir untuk mengambil pesanan")
            ]
              ),
        ),
        ),
    );
  }
}
