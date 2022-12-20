import 'dart:ui';

import 'package:e_commerce/utils/inputs_rules.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingController extends GetxController {
  var switchValue = false.obs;
  var storage = GetStorage();
  var langLocal = ene;
  String capitalize(String profileName) {
    return profileName.split(" ").map((name) => name.capitalize).join(
        " "); //kullanicinin adi ilk harfi buyuk olsun diye bu kodu kullandik cameCase gibi olack
  }

  @override
  void onInit() async {
    langLocal = await getLanguage;//son ekledigmiz dil
    super.onInit();

  }

  void saveLanguage(String lang) async {
    await storage.write("lang", lang);//write ,ethodu bilgileri kayit etmek icin kullanilir
  }

  Future<String> get getLanguage async {
    return await storage.read("lang");
  }

  void changeLanguage(String typeLang) {
    Get.updateLocale(Locale(typeLang));//updateLocal methodu ekranda dili degistirmek icin kullaniilir
    saveLanguage(typeLang);
    if (langLocal == typeLang) {
      return;
    }

    if (typeLang == trt) {
      langLocal = trt;
      saveLanguage(trt);
    } else if (typeLang == ene) {
      langLocal = ene;
      saveLanguage(ene);
    } else {
      langLocal = ara;
      saveLanguage(ara);
    }

    update();
  }
}
