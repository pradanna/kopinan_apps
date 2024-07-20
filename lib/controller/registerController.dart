import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../apiRequest/apiServices.dart';

class RegisterController extends GetxController {
  var email = ''.obs;
  var fullName = ''.obs;
  var address = ''.obs;
  var username = ''.obs;
  var phoneNumber = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var isLoading = false.obs;

  dio.Dio _dio = dio.Dio();

  void register() async {
    if (password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading(true);
    var formData = dio.FormData.fromMap({
      'username': username.value,
      'email': email.value,
      'name': fullName.value,
      'password': password.value,
      // 'alamat': address.value,
      'phone': phoneNumber.value,
    },);
    try {
      final response = await _dio.post(
        baseURL+'/api/register',
        data: formData,
          options: dio.Options(headers: {'Accept': 'application/json'})
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Registration successful');
        Get.offAllNamed('/login');
      } else {
        Get.snackbar('Error', 'Registration failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
