import 'package:e_commerce/logic/bindings/auth_binding.dart';
import 'package:e_commerce/logic/bindings/main_binding.dart';
import 'package:e_commerce/logic/bindings/product_binding.dart';
import 'package:e_commerce/logic/controllers/product_controller.dart';
import 'package:e_commerce/view/screens/auth/forget_password_screen.dart';
import 'package:e_commerce/view/screens/auth/login_screen.dart';
import 'package:e_commerce/view/screens/auth/signup_screen.dart';
import 'package:e_commerce/view/screens/cart_screen.dart';
import 'package:e_commerce/view/screens/main_screen.dart';
import 'package:e_commerce/view/screens/payment_screen.dart';
import 'package:e_commerce/view/screens/product_details_screen.dart';
import 'package:e_commerce/view/screens/welcome_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: Routes.welcomeScreen,
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: Routes.LoginScreen,
      page: () => LoginScreen(),
      binding:
          AuthBinding(), //istedigmiz sayfada AuthBindin sinifi kullanmak icin\
    ),
    GetPage(
      name: Routes.SignUpScreen,
      page: () => SignUpScreen(),
      binding:
          AuthBinding(), //Binding ozellgi GetPage  icinde olur ve AuthBinding classi SignUp sayfasinda kullanmk icin burda yazdik yoksa hata veiri
    ),
    GetPage(
      name: Routes.ForgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      binding:
          AuthBinding(), //Binding ozellgi GetPage  icinde olur ve AuthBinding classi istedigmiz class/sayfada  kullanmk icin burda yazdik yoksa hata verir ve AuthControler icndeki methodlar/degiskenleri cagiramayiz
    ),
    GetPage(name: Routes.MainScreen, page: () => MainScreen(), bindings: [
      //birden fazla class  bindings class'tan miras alan siniflari eklemek icin bindings ozelligi kullaniyoz cunku list aliyo icin ve artik bu sayfada ekledigmiz bindings classlar ve ozellikleri cagirip kullanabilirz
      AuthBinding(),
      MainBinding(),
      ProductBinding(),
    ]),
    GetPage(
        name: Routes.CartScreen,
        page: () => CartScreen(),
        bindings: [ProductBinding()]),
    GetPage(name: Routes.PaymentScreen, page: () => PaymentScreen(), bindings: [
      ProductBinding(),
      AuthBinding(),
      MainBinding(),
    ]),
  ];
}

class Routes {
  static const String welcomeScreen =
      '/WelcomeScreen'; //Get paketi kullanirken sayfa adilari once buni / koymamiz lazim
  static const String LoginScreen = '/LoginScreen';
  static const String SignUpScreen = '/SignUpScreen';
  static const String ForgotPasswordScreen = '/ForgotPasswordScreen';
  static const String MainScreen = '/MainScreen';
  static const String CartScreen = '/CartScreen';
  static const String ProductDetailsScreen = '/ProductDetailsScreen';
  static const String PaymentScreen = '/PaymentScreen';
}
