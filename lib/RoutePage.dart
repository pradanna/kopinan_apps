
import 'package:get/get.dart';
import 'package:kopinan_spps/tambahlaporan.dart';

import 'camera.dart';
import 'chooseReport.dart';
import 'controller/binding/loginBinding.dart';
import 'home.dart';
import 'login.dart';
import 'splashScreen.dart';

class RoutePage {
  List<GetPage> route = [
    GetPage(name: "/", page: () => SplashScreen()),
    GetPage(name: "/login", page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: "/home", page: () => HomeView()),
    GetPage(name: "/tambahlaporan", page: () => TambahLaporanView()),
    GetPage(name: "/camera", page: () => ImagePickerPage()),
    GetPage(name: "/chooseReport", page: () => ChooseReport()),
  ];
}
