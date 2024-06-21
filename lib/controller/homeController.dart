
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var isLoadingReport = false.obs;
  var profileData = {}.obs;
  var reports = [].obs;
  GetStorage box = GetStorage();
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
    fetchReports();
  }

  void fetchProfileData() async {
    isLoading(true);
    var token = await box.read("token");
    try {
      final response = await _dio.get('https://carbranding.genossys.com/driver/profile', options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        profileData.value = response.data;
      } else {
        Get.snackbar('Error', 'Failed to fetch profile data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching profile data');
    } finally {
      isLoading(false);
    }
  }

  void fetchReports() async {
    isLoadingReport(true);
    var token = await box.read("token");
    try {
      final response = await _dio.get('https://carbranding.genossys.com/driver/report', options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        var data = response.data['data'];
        if (data is List) {
          reports.value = data;
        } else {
          Get.snackbar('Error', 'Invalid data format');
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch reports');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching reports');
    } finally {
      isLoading(false);
    }
  }

}
