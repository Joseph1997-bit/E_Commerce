import 'package:e_commerce/services/product_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController {
  var productList = []
      .obs; //surekli ve degisen bi sekilde internetten alacagimiz bi bilgi oldugu icin Stream olark yapmamiz lazim oYuzden obs ekledik
  var isLoading = true.obs;
  var favoritesList = [].obs;
  var storage = GetStorage();
  var searchList = [].obs;
  TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    //initState ibi calisir hic biseye basmadan sayfa acinca direk calisir
    super.onInit();
    //favoritesList = (GetStorage().read<List>('favoritesList') ?? []).obs;
    favoritesList = (storage.read<List?>('favoritesList') ?? [])
        .toList()
        .obs; //kayit edilen bilgileri ekran aclinca gostermek icin read() fonksyunu kullanacz ve sadece String olarak verdigmiz anahtar bi deger aliyo

    getProducts();
  }

  getProducts() async {
    //getProduct methodu icinde Api'den json olarak aldigmiz bilgiyi bi segiskene atiyoz sonra List'ye eklemek icin
    //internetten bilgil alcagizmiz icin ve Future donduren bi method oldugu icin baska isleme gecmeden once veri gelmesini beklememiz lazim await ile
    var products = await ProductServices.getProduct();
    try {
//tipi obs oldugu icin value kelimesi eklemimz lazim
      isLoading.value = true;
      if (products.isNotEmpty) {
        productList.addAll(
            products); //json olarak gelen bilgiyi dynamic oldugu icin dynamic bi list'ye atmamiz lazim sonra listyi kullanark istedigmiz product/elemani getirip gosterbilrz
//addAll methodu kullandik cunku Map olarak bi bilgi ekleycz yoksa hata verir
      }
    } finally {
      //finally demkeki try icndeki islemleri yaptiktan sonra en son finally icndeki islemleri yap try islemleri hatali olsa bile
      isLoading.value = false;
    }
  }

  void manageFavorites(int productId) async {
//indexWhere The first index in the list that satisfies the provided test.and return 0.But if element is not found Returns -1.
    //indexWhere methodu sayesinde sectigmiz urun id'si bu fonksyuna gelir ve list icine bakilack eger varsa 0 dondureck ve asgadaki islemleri/silme yap  yoksa -1 dondureck
    //diyelim 3 tane urun sectik ve 3. urunu sildik 2 bi deger donduru bu urun'un indexi ve listde varmis.veya 1. urunu silsek 0 verir sirayla gidyo print icinde degiskeni koysak daha aciklayici olur
    var existingIndex =
        favoritesList.indexWhere((element) => element['id'] == productId);
    if (existingIndex >= 0) {
      //indexWhere kullansak sectigmiz urunler indexleri 0'dan baslaiyo -1 dondururse demeki urun/index yok
      //indexWhere methodu 0 veya daha fazla verirse demeki bu index yada urun List icinde var ve onu removeAt methodu sayesinde silecz.button tekrar basinca -1 bi sonuc verir cunku bu urun artik yok
      favoritesList.removeAt(
          existingIndex); //Removes the object at position index from this list.The index must be in the range 0 ≤ index < length. The list must be growable.

      await storage.remove(
          'favoritesList'); //remove fonksyunu kayit edilen bilgileri silmek icin kullandigmiz icin sadce String olak verdigmiz anahtar bi deger aliyo
      await storage.write('favoritesList',
          favoritesList); //storage'ten silince hepsi silinr onu tekrar eklememiz lazim yoksa favoritesList bos kalir
    } else {
      //firstWhere methodu demeki productList icinde element deiskeni sirayla gezecek ve karsina cikan koydugmuz sarti saglayan ilk eleman/urun alack ve bize verir
      //  var addProduct = productList.firstWhere((element) => element['id'] == productId); //ekranda sectigmiz urun id'sini alip listeye bakack hangi urun oldugu bulup onu Favorite'lere ekleycz
      //istdigmiz belirli bilgileri cikartmak icin bu sekilde yazmamiz lazim list[''].cunku icinde degerler Map<String,dynamic> olark atilmis Anahtar/key String olark yazilmis onu yazinca dynamic degerleri aliyz
      favoritesList.add(productList.firstWhere((element) =>
          element['id'] ==
          productId)); //urunu sectikten sonra id'sin buraya atip ve ona gore urunu favoritesList'sine ekliyoz.her urunun ayri bi id'sin var oYuzden karisik olmaz

      await storage.write('favoritesList',
          favoritesList); //write fonksyunu future bi deger dondurdugu icin await ile kullanilir
      //write fonksyunu bilgileri kayit etmek icin kullanilir ve String olark verdigmiz key/deger write ve read fonksyunu arasinda bir baglanti ve bilgileri saklayip cikarmak icin kullanilir
    }
  }

  bool isFavorites(int productId) {
    //favoritesList'ye urun ekledikten sonra any methodu kullanacz ve demeki List icinde herhangi bir urun id'si sectigmiz urunId'sine esit ise true dondur ve listye eklenmis demeki
    return favoritesList.any((element) => element['id'] == productId);
//any method.Checks every element in iteration order, and returns true if any of them make test return true, otherwise returns false.
  }

  void addSearchToList({required String searchName}) {
    searchList.value = productList.where((element) {
      return element['title'].contains(searchName);
    }).toList(); //where methodu Iterable bi deger donduru oYuzden onu list'e ceviryoz ve searchList onu kabul etmek icin value kelimesi eklememiz gerekiyo
  }

  void clearSearch() {
    searchTextController.clear();
    addSearchToList(searchName: '');
  }
}
