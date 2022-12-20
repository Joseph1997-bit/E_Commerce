import 'package:e_commerce/logic/controllers/settings_controller.dart';
import 'package:e_commerce/utils/inputs_rules.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageWidget extends StatelessWidget {
  LanguageWidget({Key? key}) : super(key: key);
  final controller = Get.find<SettingController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
        builder: (_) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: languageSettings,
                        ),
                        child: const Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextUtils(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        text: "Language".tr,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      width: 2,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 25,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            english,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          value: ene,//value ozelligine verdigmizi degeri bayragi baasinca consolda yazilacak ve bu degeri kullanarak hangi dili/falg kullanacsgimizi belirleyebilirz
                        ),
                        DropdownMenuItem(
                          child: Text(
                            arabic,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          value: ara,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            turkey,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          value: trt,//value ozelligine verdigmizi degeri bayragi baasinca consolda yazilacak ve bu degeri kullanarak hangi dili/falg kullanacsgimizi belirleyebilirz
                        ),
                      ],
                      value:
                          controller.langLocal, //value ozelligi buttoni basmadan once gosterecegimz flagi belirliyor
                      onChanged: (value) {
                        controller.changeLanguage(value!);
                        print(value);
                      },
                    ),
                  ),
                )
              ],
            ));
  }
}
