import 'package:e_commerce/logic/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings{//bu ozelligi baska yerlerde/sayfalarda kullanmak icin bu sayfada koyduk ve Bindings class'tan miras almasi lazim
  @override
  void dependencies() {
    final controller =Get.put(AuthController());//bu sayfaya girince direk AuthController sinifi  cagirip calistirabilirz onu cagirmadan hata alirz ve ekranda degismeleri goremeyiz
   // final controller1=Get.lazyPut(() => AuthController());//bu method istedigmiz zamnida cagirip calistirabilirz,button'i basinca mesela yani otomatik calismaz
  }

}