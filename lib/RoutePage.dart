
import 'package:get/get.dart';
import 'package:kopinan_spps/cartView.dart';
import 'package:kopinan_spps/historyView.dart';
import 'package:kopinan_spps/homeView.dart';
import 'package:kopinan_spps/profileView.dart';
import 'package:kopinan_spps/regisrterView.dart';
import 'controller/binding/loginBinding.dart';
import 'pesanView.dart';
import 'login.dart';
import 'splashScreen.dart';

class RoutePage {
  List<GetPage> route = [
    GetPage(name: "/", page: () => SplashScreen()),
    GetPage(name: "/login", page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: "/pesan", page: () => Pesanview()),
    GetPage(name: "/home", page: () => HomeView()),
    GetPage(name: "/register", page: () => RegisterView()),
    GetPage(name: "/cart", page: () => CartView()),
  ];
}
