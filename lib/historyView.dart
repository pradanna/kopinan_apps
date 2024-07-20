import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Components/helper.dart';
import 'controller/historyController.dart';

class HistoryView extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    controller.fetchOrderHistory();
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Transaksi'),
      ),
      body: Obx(() {
        if (controller.orderHistory.isEmpty) {
          return Center(
            child: Text('Belum ada riwayat transaksi'),
          );
        }

        return ListView.builder(
          itemCount: controller.orderHistory.length,
          itemBuilder: (context, index) {
            var order = controller.orderHistory[index];
            return Card(
              margin: EdgeInsets.all(10),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Get.toNamed("/detailtrans", arguments: {'id': order["id"]});
                      },
                      child: ListTile(
                        title: Text('Nomor Transaksi: ${order['transaction_number']}', style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 10),
                            Text('Total Point: ' + formatRupiah(order['total_point'])),
                            Text('Total Harga: ' + formatRupiah(order['total_price'])),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getOrderStatusTextSwitch(order["status_pesanan"],order["status_pembayaran"] ), style: TextStyle(color: getOrderStatusColor(order["status_pesanan"]), fontSize: 12),),
                        order["status_pesanan"] == 1 && order["status_pembayaran"] !=1 ? ElevatedButton(onPressed: (){
                          Get.toNamed('/payment', arguments: {'id': order["id"]});
                        }, child: Text('Kirim Bukti Pembayaran', style: TextStyle(fontSize: 12),)) : order["status_pesanan"] == 0 && order["status_pembayaran"] == 0 ? Obx(() => controller.isLoadingTerima.value ? Center(child: CircularProgressIndicator(),) :
                          ElevatedButton(onPressed: (){
                            Get.toNamed('/qr', arguments: {'id': order["id"]});
                          }, child: Text('QR Code')),
                        ) :  Container(height: 30,),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
