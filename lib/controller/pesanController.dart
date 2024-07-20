import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../apiRequest/apiServices.dart';

class PesanController extends GetxController {
  var userName = 'John Doe'.obs;
  var phoneNumber = '123456789'.obs;
  var isLoadingCategory = false.obs;
  var isLoadingItems = false.obs;
  var isLoading = false.obs;
  var selectedCategory = 0.obs;
  var categories = <String,dynamic>{}.obs;
  var items = <dynamic>[].obs;
  var profileData = <String, dynamic>{}.obs;

  GetStorage box = GetStorage();
  Dio _dio = Dio();

  var cartItemsCount = 0.obs;

  void addToCart(String item) {
    cartItemsCount.value++;
  }

Future<void> getCategory() async{
  print("load kategori");
  final token = await box.read('token');

  if(token == null){
    Get.offAndToNamed("login");
return;
  }

  isLoadingCategory.value == true;

  try {
    final response = await _dio.get(
      baseURL+'/api/category',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      // Store profile data
      categories.value = response.data;

    } else {
      Get.snackbar('Error', 'Failed to fetch profile data');
    }
  } catch (e) {
    Get.snackbar('Error', 'An error occurred while fetching profile data');
    print(e);
  } finally {
    isLoadingCategory(false);
  }
}


  Future<void> getItems(String id) async{
    final token = await box.read('token');

    if(token == null){
      Get.offAndToNamed("login");
      return;
    }

    isLoadingItems.value == true;
    String URL = baseURL+'/api/item';
    if(id != "0"){
      URL = baseURL+'/api/item/$id/category';
    }
    try {
      final response = await _dio.get(
        URL,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Store profile data
        items.value = response.data['data'];

      } else {
        Get.snackbar('Error', 'Failed to fetch profile data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching profile data');
      print(e);
    } finally {
      isLoadingItems(false);
    }
  }

  Future<void> getProfile() async {
    final token = await box.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isLoading(true);
    try {
      final response = await _dio.get(
        baseURL+'/api/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Store profile data
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

}
