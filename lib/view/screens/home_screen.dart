import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/home/card_items.dart';
import 'package:e_commerce/view/widgets/home/search_text_form.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            height: 170.0,
            decoration: BoxDecoration(
              color: Get.isDarkMode ? darkGreyClr : mainColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                 const TextUtils(
                    text: 'Find your',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
              const   SizedBox(
                    height: 10.0,
                  ),
                  const   TextUtils(
                    text: 'INSPIRATION',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                  const    SizedBox(
                    height: 15.0,
                  ),
                  SearchFormText(),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 TextUtils(
                    text: 'Categories',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? white : darkGreyClr),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_downward,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
           CardItems(),
        ],
      ),
    );
  }
}
