import 'package:e_commerce/view/screens/category_screen.dart';
import 'package:e_commerce/view/screens/favorites_screen.dart';
import 'package:e_commerce/view/screens/home_screen.dart';
import 'package:e_commerce/view/screens/setings_screen.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs; //backend'dan stream olarak gelen data/bilgi obs ile calistiracz cunku HomeScreen sayfasinda surekli degismeler olacak ve bu degismeleri ekranda gostermek icin obs ve RXint olmasi lazim

  final tabs = [
    HomeScreen(),
    CategoryScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ].obs;

  final title=[
    'Joseph Shop',
    'Categories',
    'Favorite',
    'Settings'
  ];

}
