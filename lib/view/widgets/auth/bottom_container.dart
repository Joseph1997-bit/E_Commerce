import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomContainer extends StatelessWidget {
  final String text;
  final String buttonTitle;
  final Function() onPressed;
  const BottomContainer(
      {Key? key,
      required this.text,
      required this.buttonTitle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? pinkClr : mainColor,
        // borderRadius: BorderRadius.only(topRight: Radius.circular(32.0),topLeft:Radius.circular(32.0) )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextUtils(
            text: text,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          TextButton(
              onPressed: onPressed,
              child: TextUtils(
                text: buttonTitle,
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
                underLine: TextDecoration.underline,
              )),
        ],
      ),
    );
  }
}
