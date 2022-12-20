import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/logic/controllers/category_controller.dart';
import 'package:e_commerce/logic/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      //bu classi binding ozelligi kullanark istedigmiz sayfada kullanmak icin Bindings'tan miras alan bi class icinde tanimlamamiz lazim
      ProductController(),
    ); //put methodu sayfa acilinca direk calisir
    Get.lazyPut(() =>
        CartController()); //lazyPut methodu calistirmak icin buttoni basmamiz lazim.yani biz calistirmamiz lazim direk calismaz
    Get.put(CategoryController());
  }
}
