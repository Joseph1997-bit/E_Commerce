
import 'package:e_commerce/logic/controllers/main_controller.dart';
import 'package:e_commerce/logic/controllers/payment_controller.dart';
import 'package:e_commerce/logic/controllers/settings_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings{
  @override//asgadaki method zorunlu bi override eklememiz lazim
  void dependencies() {
    Get.put(MainController());//MainController classi ve icndeki methodlari put methodu ile gtirip GetPage icndeki binding ozellige ekliyoz istedigmiz sayfada MainController sinifi kullanmak icin
  Get.put(SettingController() );
  Get.put(PayMentController());
  }

}