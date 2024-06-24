import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class RegisterController extends GetxController {
  var email = ''.obs;
  var fullName = ''.obs;
  var address = ''.obs;
  var phoneNumber = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var isLoading = false.obs;

  Dio _dio = Dio();

  void register() async {
    if (password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading(true);

    try {
      final response = await _dio.post(
        'https://yourapiurl.com/register',
        data: {
          'email': email.value,
          'full_name': fullName.value,
          'address': address.value,
          'phone_number': phoneNumber.value,
          'password': password.value,
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Registration successful');
        Get.offAllNamed('/login');
      } else {
        Get.snackbar('Error', 'Registration failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
    }
  }
}
