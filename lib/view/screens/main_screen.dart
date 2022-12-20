import 'package:badges/badges.dart';
import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/logic/controllers/main_controller.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final controller = Get.find<
      MainController>(); //MainController sinifi ve icndeki methodlar/degiskenker kullanmk icin Get.find method uullanip ve turu belirlyip conreoller degiskne attik
final cartController=Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //MainScreen oldugu icin sayfalar arasinda surekli degismeler olabilir ve bunlari gostermek icin Obx kullanacz StreamBuilder gibi calisir
      return SafeArea(
        child: Scaffold(
          backgroundColor: context.theme
              .backgroundColor, //context.theme demeki scaffold icndeki text'in rengi ters olsun yada gozksun yani arka reng siyah ise text/widget rengi beyaz olack ve boylece
          appBar: AppBar(
            //eger diger sayflarda appBar ozelligi eklesek her sayfada iki tane appBar cikar ekranda
            elevation: 0,
            backgroundColor: Get.isDarkMode
                ? darkGreyClr
                : mainColor, //scaffold icin eger darkMode true ise arka reng siyah olsun degilse beyaz olsun
            leading: Container(),
            actions: [
              Obx(() {
                return Badge(//ShopingCart'a basinca ekrada yukarda sagda ne kadar urun/product eklediysek o kadar yazilack animation olarak
                  position: BadgePosition.topEnd(top: 0, end: 3),
                  animationDuration: const Duration(milliseconds: 300),
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                   cartController.quantity().toString() ,
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.CartScreen);
                    },
                    icon: Image.asset('images/shop.png'),
                  ),
                );
              })

              /*IconButton(
                onPressed: () {
                  Get.toNamed(Routes.CartScreen);
                },
                icon: Image.asset('images/shop.png'),
              ),*/
            ],
            centerTitle: true,
            title: Text(controller.title[controller.currentIndex
                .value]), //her sayfanin Title getirmek icin title listesi ekliyoz ve icndeki sayfanin indexi atiyoz sayfa secince onun indexi otomatik oraya gider
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Get.isDarkMode
                ? darkGreyClr
                : mainColor, //BottomNavigationBar icin eger darkMode true ise arka reng siyah olsun degilse yesil olsun
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                  color: Get.isDarkMode
                      ? pinkClr
                      : white, //eger darkMode true ise secili icon  rengi pembe olsun degilse beyaz olsun
                ),
                icon: Icon(
                    Icons
                        .home, //secili olmayan iconlar icim eger darkMode true ise arka reng siyah olsun degilse yesil olsun
                    color: Get.isDarkMode ? white : darkGreyClr),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.category,
                  color: Get.isDarkMode ? pinkClr : white,
                ),
                icon: Icon(Icons.category,
                    color: Get.isDarkMode ? white : darkGreyClr),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.favorite,
                  color: Get.isDarkMode ? pinkClr : white,
                ),
                icon: Icon(Icons.favorite,
                    color: Get.isDarkMode ? white : darkGreyClr),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.settings,
                  color: Get.isDarkMode ? pinkClr : white,
                ),
                icon: Icon(Icons.settings,
                    color: Get.isDarkMode ? white : darkGreyClr),
                label: '',
              ),
            ],

            currentIndex: controller.currentIndex
                .value, //currentIndex ozelligi int bi deger aldigi icin atacagimiz listenin inedx value kelimesi ile int' ceviriyoz
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              //asgadki BottomNavigationBar icno'u tiklayinca gelen index degeri currentIndex'e atiyoz ve ekranda Iconlarin degismeleri gorecz
              controller.currentIndex.value = index;
            },
          ),
//sayfalar arsinda gezerken her sayfa icndeki scaffold/icerikleri gostermek icin Mainsayfasinda body ozellige IndexedStack widgeti kullanmk lazim yoksa gostermez
          body: IndexedStack(
            index: controller.currentIndex
                .toInt(), //hangi sayfayi sectigmizi belirlemk icin sayfanin indexi alip index ozellige atiyoz
            children: controller
                .tabs, //bu IndexedStack widgeti children ozelligne asyfalarin listesi atiyoz
          ),
        ),
      );
    });
  }
}
