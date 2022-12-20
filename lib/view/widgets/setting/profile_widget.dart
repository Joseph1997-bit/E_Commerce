import 'package:e_commerce/logic/controllers/auth_controller.dart';
import 'package:e_commerce/logic/controllers/settings_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({Key? key}) : super(key: key);
  final controller = Get.find<SettingController>();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              decoration:  BoxDecoration(
                  color: white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          authController.displayUserPhoto.value),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              //kullanici adi uzun olsa bile ekanda hata cikmaz ve yer alir
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, //adi ve email solda ayni hizada baslasin diye kullandim
                children: [
                  TextUtils(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    text: controller.capitalize(authController.displayUserName
                        .value), //tipi Rx oldugu icin value kelimesi eklemeiz lazim yoksa degerler eşleşmeyecek
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  TextUtils(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    text: controller.capitalize(authController.displayUserEmail.value),
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
