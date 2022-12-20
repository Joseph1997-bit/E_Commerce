

import 'package:e_commerce/services/category_services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categoryNameList = <String>[].obs;
  var categoryList = [].obs;
  var isCatgeoryLoading = false.obs;

  var isAllCategory = false.obs;

  List<String> imageCategory = [
    "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg",
    "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
    "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
    "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
  ].obs;

  @override
  void onInit() {
    super.onInit();
    getCategorys();
  }

  void getCategorys() async {
    var categoryName = await CategoryServices.getCategory();//categortlerin adilarini getirip categoryName degiskene atiyoz sonra tum adilari listeye ekliyoz

    try {
      isCatgeoryLoading(true);
      if (categoryName.isNotEmpty) {
        categoryNameList.addAll(categoryName);
      }
    } finally {
      isCatgeoryLoading(false);
    }
  }

 getAllCategorys(String namecategory) async {
    isAllCategory(true);
    categoryList.value = await AllCategorySercvises.getAllCategory(namecategory);

    isAllCategory(false);
  }

  getCategoryIndex(int index) async {//categoryleri cagirinca zaman aliyo o yuzden category adi/indexi getirmeden once bekleycz sonra categorydaki urunleri getirecz ve ikisi await ile yapmamiz gerek
    var categoryAllName = await getAllCategorys(categoryNameList[index]);

    if (categoryAllName != null) {
      categoryList.value = categoryAllName;
    }
  }
}