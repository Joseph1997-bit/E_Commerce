import 'package:e_commerce/language/localization.dart';
import 'package:e_commerce/logic/controllers/theme_controller.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/utils/inputs_rules.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); //GetStorage methodu baslatmamiz lazim
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //when we should put get befor the MaterialApp This step is only necessary if you gonna use route management (Get.to(), Get.back() and so on). If you not gonna use it then it is not necessary to do step 1
      debugShowCheckedModeBanner: false,
      theme: ThemesApp
          .light, //Light degiskeni static oldugu icin class adi kullanark direk ulasabilirz
      darkTheme: ThemesApp
          .dark, //lisght ve dark yerine flutter'dan verilen ThemesApp degeri kullanabilirz
      themeMode: ThemeController()
          .themeDataGet, //themeMode ozelligine deger vermewzsek son modu kayit edemz
//local ozelligi uygulama hangi dil ile baslayacgi karar veriyo
      locale: Locale(GetStorage()//getStorge ile son kayit etigimz dili gosterebilirz
          .read<String>('lang')
          .toString()),
      translations:
          LocaliztionApp(), //tarnslation ozelligi dilleri degistirmek icin kullanilir
      fallbackLocale: Locale(
          ene), //fallbackLocale ozelligi herhangi bir dil ile sorun olursa hangi dil onun yerine gecer diye karar veriyo
//Farebase ile giris yaptiktan sonra storage'ta kait etmemize gerek yok cunku zaten farebase'te kayd ediliyo
      initialRoute: FirebaseAuth.instance.currentUser != null ||
              GetStorage().read<bool>('auth') == true
          ? Routes.MainScreen
          : Routes.welcomeScreen,
      getPages: AppRoutes
          .routes, //giris yapildiysa main sayfasi ile baslasin yapilmadiysa  welcomHome sayfasi ile baslasin
      //farebase girisi null/bos degilse yani giris yapildiysa veya facebook/google girisi yapildayisa ve write degeri true ise demeki giris yapildi
      //ve bu girisleri read'methodu ile okuyp uygulama calisnca onunla baslasin ve main sayfayi acsin.read<bool> fonksyunu tipi bool belirlememiz lazim yoksa calismaz.
    );
  }
}
