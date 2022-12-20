import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElevatedAuthButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const ElevatedAuthButton({Key? key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            primary: Get.isDarkMode ?pinkClr:mainColor , minimumSize: Size(360, 50)),
        child:  TextUtils(
          text: text,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ));
  }
}
