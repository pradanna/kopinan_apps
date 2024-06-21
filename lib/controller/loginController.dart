import 'package:get/get.dart';

import '../apiRequest/apiServices.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final ApiService _apiService = ApiService();

  void login() async {
    isLoading(true);
    // Simulasikan proses login

    // Jika login berhasil, navigasi ke halaman berikutnya
    try {
      print('try to Login ' + email.value + " " + password.value);
      final response = await _apiService.login(email.value, password.value);

      if (response.statusCode == 200) {
        // Handle successful login
        Get.offNamed("/home");
        print('Login successful ' + response.toString());
      } else {
        errorMessage('Login failed: ${response.data['message']}');
      }
    } catch (e) {
      errorMessage('Login failed: $e');
      print(e);
    } finally {
      isLoading(false);
      print('Login Finaly');
    }
  }
}
