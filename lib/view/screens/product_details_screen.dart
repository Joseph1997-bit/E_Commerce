import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/view/widgets/product_details/add_cart.dart';
import 'package:e_commerce/view/widgets/product_details/clothes_Info.dart';
import 'package:e_commerce/view/widgets/product_details/image_sliders.dart';
import 'package:e_commerce/view/widgets/product_details/size_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productImage;
  final String title;
  final int productId;
  final num rate;
  final num price;
  final String description;
  ProductDetailsScreen(
      {required this.productImage,
      required this.title,
      required this.productId,
      required this.rate,
      required this.description,
      required this.price});

  //final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageSliders(
                imageUrl: productImage,
              ),
              ClothesInfo(
                title: title,
                productId: productId,
                rate: rate,
                description: description,
              ),
              const SizeList(),
              AddCart(price: price, productId: productId),
            ],
          ),
        ),
      ),
    );
  }
}
