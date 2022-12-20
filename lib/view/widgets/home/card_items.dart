import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/logic/controllers/product_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/screens/cart_screen.dart';
import 'package:e_commerce/view/screens/product_details_screen.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardItems extends StatelessWidget {
  CardItems({Key? key}) : super(key: key);
  final controller = Get.find<ProductController>();
  final cartController = Get.find<CartController>();
  var totalPrice;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        //isLoading true ise yani bilgi getirliyo oZa,an ekranda  kucuk bi bekleme dairesi gozuksun bilgi gelene kadar
        return Center(
          child: CircularProgressIndicator(
            color: Get.isDarkMode ? pinkClr : mainColor,
          ),
        );
      } else {
        //Expanded widgeti vermezsek butun ekrani kapsamaya calisack ve bize hata verir
        return Expanded(
          //Creates a scrollable, 2D array of widgets that are created on demand.yani harekt edilebilir bi dizi istedigmizde yapilack yapilacak.Tam ListView.builder gibi calisir
          //This constructor is appropriate for grid views with a large (or infinite)
          // number of children because the builder is called only for those children
          // that are actually visible.
          child: controller.searchList.isEmpty && controller.searchTextController.text.isNotEmpty//eger search listesi bos ise ve arama alani bos degilse demeki urun bulunmadi ve bize uyari gostereck foto olarak
              ? Get.isDarkMode?Image.asset('images/search_empty_dark.png'):Image.asset('images/search_empry_light.png')
              : GridView.builder(
                  itemCount: controller.searchList.isEmpty
                      ? controller.productList.length
                      : controller.searchList.length,
                  //ekranda item/widget'larin sayisini temsil ediyo
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        2, //ekranda her satirda kac tane gostercek onu belirliyo 2 yazsak yani her satirda 2 widget gosterck
                    mainAxisExtent:
                        240, //ekranda itemlarin veya widgetlari boyutunu belirliyo
                    mainAxisSpacing:
                        15, //itemlarin veya widgetlarin arsanda sutun olark meafe belirliyo
                    crossAxisSpacing:
                        15, ////itemlarin veya widgetlarin arsanda satilar arasinda mesafe belirliyo
                  ),
                  itemBuilder: (context, index) {
                    if (controller.searchList.isEmpty) {
                      return buildCardItems(
                          //Api'den ve json olarak gelen bilgi ve Listeye atiktan sonra bu sekilde cikariyo.List[index]['image']
                          image: controller.productList[index][
                              'image'], //ilk bastan urun/eleman indexi sonra urun icnde istedigmiz bilgi anaharti yazip degeri alabilirz Map gibi calisir
                          price: controller.productList[index]['price'],
                          rate: controller.productList[index]['rating']['rate'],
                          productId: controller.productList[index]['id'],
                          onTap: () {
                            Get.to(
                              () => ProductDetailsScreen(
                                  productImage: controller.productList[index]
                                      ['image'],
                                  title: controller.productList[index]['title'],
                                  productId: controller.productList[index]
                                      ['id'],
                                  rate: controller.productList[index]['rating']
                                      ['rate'],
                                  description: controller.productList[index]
                                      ['description'],
                                  price: controller.productList[index]
                                      ['price']),
                            );
                          });
                    } else {
                      return buildCardItems(
                          //Api'den ve json olarak gelen bilgi ve Listeye atiktan sonra bu sekilde cikariyo.List[index]['image']
                          image: controller.searchList[index][
                              'image'], //ilk bastan urun/eleman indexi sonra urun icnde istedigmiz bilgi anaharti yazip degeri alabilirz Map gibi calisir
                          price: controller.searchList[index]['price'],
                          rate: controller.searchList[index]['rating']['rate'],
                          productId: controller.searchList[index]['id'],
                          onTap: () {
                            Get.to(
                              () => ProductDetailsScreen(
                                  productImage: controller.productList[index]
                                      ['image'],
                                  title: controller.productList[index]['title'],
                                  productId: controller.productList[index]
                                      ['id'],
                                  rate: controller.productList[index]['rating']
                                      ['rate'],
                                  description: controller.productList[index]
                                      ['description'],
                                  price: controller.productList[index]
                                      ['price']),
                            );
                          });
                    }
                  },
                ),
        );
      }
    });
  }

  Widget buildCardItems({
    required String image,
    required var price, //price ve rate degerleri bazen int bazen double olyo oYuzden var koyduk hata cikmasin diye
    required var rate, //veya String olark tanimlayip gelen price deger String'a cevirip sonra buraya atip ekranda gosterbilirz
    required int productId,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(
        5.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Get.isDarkMode
                      ? kCOlor1.withOpacity(0.4)
                      : Colors.grey.withOpacity(0.1),
                  spreadRadius:
                      4.0, //spreadRadius yani kenarlari daire yapan ozellik
                  blurRadius:
                      2.0 //ekranda item/widgelarin shado'nun kaletesi yada goruntusu gostern ozellik
                  ),
            ],
          ),
          child: Column(
            children: [
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        //her product'in/urun id'sini List'den cikartiktan sonra input olarak productId degiskene atiyoz sonra manageFavorites methoduna atip orda deger islemeler devam eder
                        controller.manageFavorites(
                            productId); //ekranda gorunen her urun'un ayrin bi indexi ve id'si var oYuzden ona gore button'i basinca hangi urunu sectigmizi belirleyebilirz
                      }, //products/urunlerin bilgileri productList'ye ekledikten sonra id'leri cikartip isFavorites methoduna atiyoz
                      icon: controller.isFavorites(
                              productId) //isFavorites method icinde favoritesList'ye urun ekledikten sonra  List icinde herhangi bir urun id'si sectigmiz urunId'sine esit ise true dondur ve kalp rengi degissin
                          ? const Icon(
                              Icons.favorite,
                              color: red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: darkGreyClr,
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        cartController.addProductToCart(productId: productId);
                        cartController.totalPrice(totalPrice: price);
                        Get.snackbar(
                          'Done',
                          'You have added product to the Shopping List',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.brown,
                          colorText: white,
                          icon: const Icon(Icons.done),
                          duration: const Duration(seconds: 2),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Get.isDarkMode ? white : darkGreyClr,
                      ),
                    ),
                  ],
                );
              }),
              Container(
                width: double.infinity,
                height: 140.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Image.network(image),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUtils(
                        text: '\$ $price',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? white : darkGreyClr),
                    Container(
                      height: 20.0,
                      width: 55.0,
                      decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextUtils(
                                text: '$rate',
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: darkGreyClr),
                            const Icon(
                              Icons.star,
                              size: 15.0,
                              color: darkGreyClr,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
