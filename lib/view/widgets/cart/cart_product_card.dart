import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductCard extends StatelessWidget {
  CartProductCard(
      {required this.image,
      required this.title,
      this.price,
      required this.productId});

  final String image;
  final String title;
  late  dynamic price;
  final int productId;
  RxInt itemNum = 1.obs;
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? pinkClr.withOpacity(0.7)
            : mainColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
//  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 120,
            width: 100,
            margin: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            //TextOverflow.ellipsis, ozelligi calissin diye Expanded icinde koymamiz lazim.sonra title yananda 3 nokta cikabilr
            flex: 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "\$ ${price}",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() {//icnde degisme olack ana eidgeti Obx icinde koymamiz lazim ve kullandigmiz degiskenler obs tipi olmasi lazim yoksa hata calismaz
                return  Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        itemNum --;

                        if (itemNum <= 1) {
                          itemNum = 1.obs;
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        color: Get.isDarkMode ? white : darkGreyClr,
                      ),
                    ),
                    Text(
                      " ${itemNum.toString()}",
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        itemNum++;

                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                );
              }),

              IconButton(
                  onPressed: () {
                    cartController.removeProductsFarmCart(productId: productId);
                    cartController.total -=price;
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 22.0,
                    color: Get.isDarkMode ? white : red,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
