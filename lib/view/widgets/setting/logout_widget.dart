import 'package:e_commerce/logic/controllers/auth_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOutWidget extends StatelessWidget {
   LogOutWidget({Key? key}) : super(key: key);
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) => Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.defaultDialog(//Get paketi kullanark button'i bainca ekranda default bi Dialog cikar logOut yapmadan once
              title: 'LogOut of the App',
              titleStyle: const TextStyle(
                  fontSize: 18.0,
                  color: white,
                  fontWeight: FontWeight.bold),
              middleText: 'Are you sure you need to logOut',
              middleTextStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: white),
              backgroundColor: kCOlor2,
              radius: 20.0, //kenarlari dare gibi yapmak
              textCancel: 'No',
              cancelTextColor: darkGreyClr,
              textConfirm: 'Yes',
              confirmTextColor: darkGreyClr,
              onConfirm: () {
                controller.signOutFormApp();
              },
              buttonColor: Colors.red[400]);
        },
        splashColor: Get.isDarkMode ? pinkClr : mainColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8.0),//button bastiktan sonra etrafi daire gibi olacak
        customBorder: const StadiumBorder(),//button bastiktan sonra etrafi yuvarlak olmasina izin veriyo
        child: Row(
          children: [
            Container(
              //darkMod iconu daire icinde koymak icin Container ve shape ozelligi kullandim
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: logOutSettings,
              ),
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            TextUtils(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              text: "LogOut".tr//Map turunden olusturdugmuz degiskeni(tr) cagirip dili degisterebilirz ve anahtar kelimesi ayni olmasi lazim(LogOut)
              ,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    ),);
  }
}
