import 'package:get/get.dart';

class PesanController extends GetxController {
  var userName = 'John Doe'.obs;
  var phoneNumber = '123456789'.obs;

  var selectedCategory = 0.obs;

  var categories = ['Makanan', 'Kopi', 'Non Kopi'].obs;
  var items = {
    'Makanan': ['Nasi Goreng', 'Mie Goreng', 'Sate'],
    'Kopi': ['Americano', 'Latte', 'Cappuccino'],
    'Non Kopi': ['Teh', 'Jus', 'Air Mineral']
  }.obs;

  var cartItemsCount = 0.obs;

  void addToCart(String item) {
    cartItemsCount.value++;
  }
}
