import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Components/helper.dart';
import '../apiRequest/apiServices.dart';

class CartController extends GetxController {
  var isAddingToCart = false.obs;
  final dio.Dio _dio = dio.Dio();
  final GetStorage storage = GetStorage();
  var isLoadingCart = false.obs;
  var totalQuantity = 0.obs;
  var totalPrice = 0.obs;
  var cartItems = <dynamic>[].obs;
  var cartItemsCount = 0.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  Future<void> addToCart(int idbarang, int qty, String note, bool isPoint) async {
    isAddingToCart(true);


    final token = await storage.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }


    var data = dio.FormData.fromMap({
      'item_id': idbarang,
      'qty': qty,
      'note': note,
      'is_point': isPoint
    });


    try {
      print(baseURL+'/api/cart');

      final response = await _dio.request(
        '$baseURL/api/cart',
        data:
          data
        ,
        options: dio.Options(
          method: 'POST',

          headers: {
            'Authorization': 'Bearer $token',
          },
        ),

      );


      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Item added to cart successfully');
        Get.toNamed("/home");
      } else {
        Get.snackbar('Error', 'Failed to add item to cart');
      }
    }  catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('Error: $e');
      if (e is dio.DioException) {
        handleDioError(e);
      } else {
        print('Error: $e');
        Get.snackbar('Error', 'An unknown error occurred');

      }
    } finally {
      isAddingToCart(false);
      // getCartItems();
    }
  }

  void handleDioError(dio.DioException e) {

    switch (e.type) {
      case dio.DioExceptionType.connectionTimeout:
      case dio.DioExceptionType.sendTimeout:
      case dio.DioExceptionType.receiveTimeout:
        Get.snackbar('Error', 'Connection timed out');
        break;
      case dio.DioExceptionType.badResponse:
      // The server response with a 4xx or 5xx status code.
        print('Response data: ${e.response?.data}');
        print('Response headers: ${e.response?.headers}');
        print('Response request: ${e.response?.requestOptions}');
        Get.snackbar(
            'Error', 'Received invalid status code: ${e.response?.statusCode}');
        break;
      case dio.DioExceptionType.cancel:
        Get.snackbar('Error', 'Request to API server was cancelled');
        break;

      case dio.DioExceptionType.badCertificate:
      // TODO: Handle this case.
      case dio.DioExceptionType.connectionError:
      // TODO: Handle this case.
      case dio.DioExceptionType.unknown:
      // TODO: Handle this case.
    }
  }

  Future<void> getCartItems() async {
    print("get Cart Items");
    final token = await storage.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isLoadingCart(true);
    try {
      final response = await _dio.get(
        baseURL+'/api/cart',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data['data'].toString());
        cartItems.value = response.data['data'].map((item) {
          return {
            'id': item['id'],
            'name': item['name'],
            'price': num.parse(item['price'].toString()), // Ensure this is num
            'qty': num.parse(item['qty'].toString()), // Ensure this is num
            'image': item['item']['image'],
            'barangs': item['item'],
            'total': item['sub_total'],
          };
        }).toList();

        // Calculate total quantity
        totalQuantity.value = cartItems.fold(0, (sum, item) => (sum +  item['qty']).toInt());
        totalPrice.value = cartItems.fold(0, (sum, item) => (sum +  item['total']).toInt());
        print(totalQuantity);
      } else {
        Get.snackbar('Error', 'Failed to fetch cart data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching cart data');
    } finally {
      isLoadingCart(false);
    }
  }

  Future<void> removeItemFromCart(int id) async {
    final token = await storage.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    try {
      final response = await _dio.post(
        baseURL+'/api/cart/$id/delete',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        cartItems.removeWhere((item) => item['id'] == id);
        totalQuantity.value = cartItems.fold(0, (sum, item) => (sum +  item['qty']).toInt());
        totalPrice.value = cartItems.fold(0, (sum, item) => (sum +  item['total']).toInt());
        Get.snackbar('Success', 'Item removed from cart');
      } else {
        Get.snackbar('Error', 'Failed to remove item from cart');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while removing item from cart');
      print("Error Remove $e");
    }
  }

  Future<void> checkout() async {
    final token = await storage.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isAddingToCart(true);
    try {
      final response = await _dio.post(
        baseURL+'/api/cart/checkout',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Item Berhasil di Checkout');
      } else {
        Get.snackbar('Error', 'Failed to add item to cart');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred while adding item to cart');
    } finally {
      isAddingToCart(false);
      Get.toNamed("/home");
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      print(picked.toString());
      print(formatDate(selectedDate.value));
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
      print(picked.toString());
      print('${selectedTime.value.hour.toString().padLeft(2, '0')}:${selectedTime.value.minute.toString().padLeft(2, '0')}:00');

    }
  }
}
