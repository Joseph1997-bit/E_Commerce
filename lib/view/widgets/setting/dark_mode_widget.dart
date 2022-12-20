import 'package:e_commerce/logic/controllers/settings_controller.dart';
import 'package:e_commerce/logic/controllers/theme_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModeWidget extends StatelessWidget {
  DarkModeWidget({Key? key}) : super(key: key);
  final controller = Get.find<SettingController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildIconWidget(),
        Switch(
            value: controller.switchValue.value //switchValue degiskeni obs oldugu icin baska yere atarkenn value kelimesi kullanmamiz gerekiyo
            ,
            onChanged: (value) {
              ThemeController()
                  .changesTheme(); //buttoni basinca tum renkleri degistireck
              controller.switchValue.value = value;
            },
          activeTrackColor: Colors.pink,
        activeColor:  Colors.pinkAccent ,
          inactiveTrackColor: Colors.green,
          inactiveThumbColor: Colors.greenAccent,

        )
      ],
    ));
  }

  Widget buildIconWidget() {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            //darkMod iconu daire icinde koymak icin Container ve shape ozelligi kullandim
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: darkSettings,
            ),
            child: const Icon(
              Icons.dark_mode,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          TextUtils(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            text: "Dark Mode".tr,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
