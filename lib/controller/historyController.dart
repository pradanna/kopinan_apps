import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../apiRequest/apiServices.dart';

class HistoryController extends GetxController {
  var orderHistory = <Map<String, dynamic>>[].obs;
  final Dio _dio = Dio();
  final storage = GetStorage();
  var isLoadingTerima = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  void fetchOrderHistory() async {
    try {
      final token = storage.read('token');
      final response = await _dio.get(
        baseURL+'/api/transaction',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("fetch data history "+response.data['data'].toString());
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> history = List<Map<String, dynamic>>.from(response.data['data']);
        orderHistory.value = history;
      } else {
        print('Failed to fetch order history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order history: $e');
    }
  }


}
