import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../apiRequest/apiServices.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  dio.Dio _dio = dio.Dio();
  final GetStorage box = GetStorage();

  void login() async {

    isLoading(true);

    var formData = dio.FormData.fromMap({'username': username.value,
      'password': password.value,});

    try {
      final response = await _dio.post(
        baseURL+'/api/login',
        data: formData, options: dio.Options(headers: {'Accept': 'application/json'})
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Login successful');
        await box.write('token', response.data['data']['access_token']);

        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', 'Login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi Kesalahan');
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
