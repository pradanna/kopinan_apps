import 'package:get/get.dart';

class KeranjangController extends GetxController {
  var amount = 0.0.obs;
  var items = <Map<String, dynamic>>[].obs;

  // Contoh barang yang sudah dipesan
  void fetchItems() {
    items.value = [
      {'name': 'Kopi Hitam', 'price': 15000, 'quantity': 2},
      {'name': 'Roti Bakar', 'price': 10000, 'quantity': 1},
      // Tambahkan item lainnya di sini
    ];
    calculateTotalAmount();
  }

  void calculateTotalAmount() {

  }

  void makePayment() {
    // Logika untuk pembayaran
    print("Pembayaran sebesar Rp${amount.value} telah dilakukan.");
    // Anda bisa menambahkan logika untuk memproses pembayaran di sini
  }

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }
}
