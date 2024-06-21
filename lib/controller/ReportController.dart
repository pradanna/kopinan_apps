import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ReportController extends GetxController {
  final Dio.Dio dio = Dio.Dio();
  GetStorage box = GetStorage();
  var isLoading = false.obs;
  var uploadProgress = 0.0.obs; // Track upload progress

  Future<void> sendReport(
      String type, String lat, String lng, String imagePath) async {
    try {
      isLoading.value = true;
      String fileName = imagePath.split('/').last;
      var token = await box.read("token");

      var formData = Dio.FormData.fromMap({
        'type': type,
        'latitude': lat,
        'longitude': lng,
        'file': await Dio.MultipartFile.fromFile(imagePath, filename: fileName),
      });

      final response = await dio.post(
          'https://carbranding.genossys.com/driver/report',
          data: formData, onSendProgress: (int sent, int total) {
        uploadProgress.value = sent / total;
      }, options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Report sent successfully');
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', 'Failed to send report');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print('ERROR SENDDATA ' + e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
