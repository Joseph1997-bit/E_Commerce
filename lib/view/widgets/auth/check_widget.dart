import 'package:e_commerce/logic/controllers/auth_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckBoxWidget extends StatelessWidget {
  CheckBoxWidget({Key? key}) : super(key: key);
  final controller = Get.find<AuthController>();//Getx paketin ozelligi bu widget tree icinde olmazsa bile yinede ona olasip kullanabilirz
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      return InkWell(
        onTap: () {
          controller.checkBox();

        },
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child:  Icon(
                 controller.isCheckBox? Icons.done:Icons.clear,
                  size: 30,
               color: Get.isDarkMode ?   pinkClr:mainColor  ,
                ),
        ),
      );
    });
  }
}
