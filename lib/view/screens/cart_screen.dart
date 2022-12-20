import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/logic/controllers/product_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/cart/cart_product_card.dart';
import 'package:e_commerce/view/widgets/cart/cart_total.dart';
import 'package:e_commerce/view/widgets/cart/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final controller = Get.find<ProductController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: AppBar(
            title: const Text("Cart Items"),
            elevation: 0,
            backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  cartController.clearAllProducts();
                },
                icon: const Icon(Icons.backspace),
              ),
            ],
          ),
          body: Obx(() {
            if (cartController.cartList.isEmpty) {
              return const EmptyCart();
            } else {
              return SingleChildScrollView(   //icnde degisme olack ana eidgeti Obx icinde koymamiz lazim ve kullandigmiz degiskenler obs tipi olmasi lazim yoksa hata calismaz
                child: Column(children: [
                  SizedBox(
                    height:
                        550.0, //SizedBox icindeki widgeti kapsayacigi alani height ile belirliyorz.ve bu sekildeBottom'da bulunan widget sabit kalir
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return CartProductCard(
                              title: cartController.cartList[index]['title'],
                              image: cartController.cartList[index]['image'],
                              price: cartController.cartList[index]['price'],
                              productId: cartController.cartList[index]['id']);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 20.0,
                            ),
                        itemCount: cartController.cartList.length),
                  ),
                  CartTotal(),
                ]),
              );

            }
          })),
    );
  }
}
