import 'package:e_commerce/logic/controllers/category_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/screens/category_screen.dart';
import 'package:e_commerce/view/widgets/category/category_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryWidget extends StatelessWidget {
   CategoryWidget({Key? key}) : super(key: key);
  final controller = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isCatgeoryLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: Get.isDarkMode ? pinkClr : mainColor,
          ),
        );
      } else {
        return Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    controller.getAllCategorys(controller.categoryNameList[index]);
                    //controller.getCategoryIndex(index);
                    Get.to(() => CategoryItems(categoryTitle:controller.categoryNameList[index] ,));
               //     categoryTitle: controller.categoryNameList[index];
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                             controller.imageCategory[index]  ),
                            fit: BoxFit.cover)),
                    child:  Padding(
                      padding:const EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                      controller.categoryNameList[index],
                          style:const TextStyle(
                            backgroundColor: Colors.black38,
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 20.0,
              ),
              itemCount: controller.categoryNameList.length),
        );
      }

    },);
  }
}
