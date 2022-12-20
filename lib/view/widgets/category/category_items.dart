import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/logic/controllers/category_controller.dart';
import 'package:e_commerce/logic/controllers/product_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/screens/product_details_screen.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItems extends StatelessWidget {
  final String categoryTitle;
  CategoryItems({
    required this.categoryTitle,
    Key? key,
  }) : super(key: key);

  final controller = Get.find<ProductController>();

  final cartController = Get.find<CartController>();

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: Text(categoryTitle),
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
      ),
      body: Obx(() {
        if (categoryController.isAllCategory.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Get.isDarkMode ? pinkClr : mainColor,
            ),
          );
        } else {
          return GridView.builder(
            itemCount: categoryController.categoryList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 0.8,
              mainAxisSpacing: 9.0,
              crossAxisSpacing: 6.0,
              maxCrossAxisExtent: 200,
            ),
            itemBuilder: (context, index) {
              return buildCardItems(
                  image: categoryController.categoryList[index]['image'],
                  price: categoryController.categoryList[index]['price'],
                  rate: categoryController.categoryList[index]['rating']['rate'],
                  productId: categoryController.categoryList[index]['id'],
              //    productModels: categoryController.categoryList[index],
                  onTap: () {
                    Get.to(() => ProductDetailsScreen(
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
            },
          );
        }
      }),
    );
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