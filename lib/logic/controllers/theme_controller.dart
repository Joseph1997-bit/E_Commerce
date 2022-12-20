import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController {
  final GetStorage boxStorage = GetStorage();

  final key = 'isDarkMode';//key degiskeni sectigmiz modu bir ydegisken/yerde saklamak icin ve write ve read methodlar arasinda bi baglanti olark calisir
  saveThemeDataInBox(bool save) {
    boxStorage.write(key, save);
  }

  bool getThemeDataFromBox() {//button'i basinca degeri degisiyo
    return boxStorage.read<bool>(key) ??
        false; //?? demeki gelen deger null ise bu methodun degeri false yap
  }

  ThemeMode get themeDataGet =>getThemeDataFromBox() ? ThemeMode.dark : ThemeMode.light;

  void changesTheme() {
    Get.changeThemeMode(
        //getTheme methodu deger true ise ThemeMode.lite calissin degilse dark modu olsun
        getThemeDataFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeDataInBox(!getThemeDataFromBox());//sonra saveTheme methodu bool bi deger alip onu write methodu ile kait eder telefonu kaptsak bile ThemeModu tipi ayni kalir
//bu fonksyun calisnca yani buttoni basinca !getThemeDataFromBox() bu method daha once kayit etigmiz modu/degeri onun tersi ali goster ve kayd et

//getThemData methodu'nun tersini kayit edeck bu isareti ! koymazsak calismaz
    /* Get.isDarkMode//changeTheme method ve main sayfasinda them ve darkTheme sayesinde button'i basinca isDarkMode deger degistirip true ise light gosterck buttoni basinca false olup renk beyaz olur ve boylece
        ? Get.changeThemeMode(ThemeMode.light)
        : Get.changeThemeMode(ThemeMode.dark);*/
  }
}
