import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCart extends StatelessWidget {
  final num price;
  final int productId;
  AddCart({required this.price, required this.productId});
  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const TextUtils(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                text: "Price",
                color: Colors.grey,
              ),
              Text(
                "\$$price",
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(//price text yanindaki tum alani kapsamak icin ve daha guzel bi tasarim olsun diye expanded kullandik
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  primary: Get.isDarkMode ? pinkClr : mainColor,

                ),
                onPressed: () {//addToList buttoni basinca yapilan islem eger bu urun cartListesinde varsa onu sil yoksa ekle
                  controller.addProductToCart(productId: productId);
                },
                child: Row( //button icinde hem text hemde icon eklemek icin row kullandik
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Add to list",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
