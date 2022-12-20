

import 'package:e_commerce/logic/controllers/product_controller.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
var  controllerList =Get.find<ProductController>();
final cartList=[].obs;
  var productMap={}.obs;
 var total=1.0;//total degiskene bi deger vermemz lazim yoksa hata verir

  void addProductToCart({required int productId}){
    var existingIndex = cartList.indexWhere((element) => element['id'] == productId) ;//eger sectigmiz ProductId bu listede varsa Listedki onun indexi tanimladigmiz degiskene at
    if (existingIndex >= 0) {//gelen urunIdsi ege lstede varsa onu sil yoksa onu ekle
      cartList.removeAt(existingIndex);
    } else {
      cartList.add(
          controllerList.productList.firstWhere((element) =>
          element['id'] ==
              productId));
    }

  }
  void totalPrice({required totalPrice}) {
    total =( total+totalPrice) ;
  }

void removeProductsFarmCart({required int productId} ) {
  var existingIndex = cartList.indexWhere((element) => element['id'] == productId) ;//eger sectigmiz ProductId bu listede varsa Listedki onun indexi tanimladigmiz degiskene at
  if (existingIndex >= 0) {
    cartList.removeAt(existingIndex);
  }
  }
  int quantity() {// miktar/miktar
    return cartList.length;
  }

void removeOneProduct() {}

  void clearAllProducts(){//list icinde butun itemlari silmek icin clear fonksyunu kullanacz
    Get.defaultDialog( //butun itemlari silmeen  once ekranda kucuk bi Alert/9uyari ciksin
      title: "Clean Products",
      titleStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      middleText: 'Are you sure you need clear products',
      middleTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.grey,
      radius: 10,
      textCancel: " No ",
      cancelTextColor: Colors.white,
      textConfirm: " YES ",
      confirmTextColor: Colors.white,
      onCancel: () {
        Get.toNamed(Routes.CartScreen);
      },
      onConfirm: () {
        cartList.clear();
        total=0.0;
        Get.back();
      },
      buttonColor:  Colors.red,
    );


  }

}