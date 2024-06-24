import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  void addToCart(String item, double price) {
    var existingItem = cartItems.firstWhereOrNull((element) => element['name'] == item);
    if (existingItem != null) {
      existingItem['quantity']++;
    } else {
      cartItems.add({'name': item, 'price': price, 'quantity': 1});
    }
  }

  void removeFromCart(String item) {
    cartItems.removeWhere((element) => element['name'] == item);
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
}
