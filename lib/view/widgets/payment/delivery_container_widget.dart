import 'package:e_commerce/logic/controllers/auth_controller.dart';
import 'package:e_commerce/logic/controllers/payment_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryContinerWidget extends StatefulWidget {
  const DeliveryContinerWidget({Key? key}) : super(key: key);

  @override
  State<DeliveryContinerWidget> createState() => _DeliveryContinerWidgetState();
}

class _DeliveryContinerWidgetState extends State<DeliveryContinerWidget> {
  final TextEditingController phoneController = TextEditingController();
   var defulatNumber=false.obs;
  int radioContainerIndex = 1;
  bool changeColors = false;
  final controller = Get.find<PayMentController>();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildRadioContainer(
          address: "Egypt.Caro",
          name: 'joseph Shop',
          phone: '0444-555-666',
          title: 'Joseph Store',
          value: 1,
          width: 120.0,
          color: changeColors
              ? Colors.white
              : Colors.grey
                  .shade300, //radio buttoni basinca Container rengi degistirmek icin kullanilir
          icon: Container(),
          onChanged: (int? value) {
            setState(() {
              radioContainerIndex = value!;
              changeColors =
                  !changeColors; //butoni basinca eger degeri false ise true olacak tersini alacaz yani
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() => buildRadioContainer(
          address:controller.address.value,
          name: 'Joseph mahmoud',
          phone:defulatNumber==true? controller.phoneNumber.value:'12345678990',//textFielde icinde numarayi yazdiktan sonra defulat degiskeni true olacak ve yazdigmiz numara cikack false ise verdigmiz defulat degeri cikar
          title: "Delivery",
          value: 2,
          color: changeColors ? Colors.grey.shade300 : Colors.white,
          width: 120,
          icon: InkWell(
            onTap: () {
              Get.defaultDialog(
                title: "Enter Your Phone Number",
                titleStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.white,
                radius: 10,
                textCancel: " Cancel ",
                confirmTextColor: Colors.black,
                textConfirm: " Save ",
                cancelTextColor: Colors.black,
                onConfirm: () {
                  controller.phoneNumber.value=phoneController.text;
                  defulatNumber.value=true;
                  Get.back();
                },
                buttonColor: logOutSettings,
                content: Padding(
                  padding: EdgeInsets.all( 20.0),
                  child: TextField(
                    controller: phoneController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Get.isDarkMode?pinkClr.withOpacity(0.1):mainColor.withOpacity(0.2),
                      focusColor: Colors.red,
                      suffixIcon: IconButton(onPressed: (){
                        phoneController.clear();

                      }, icon: Icon(Icons.close),),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      hintText: "Enter the number",
                      hintStyle: const TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Icon(
              Icons.contact_phone,
              color: Get.isDarkMode ? pinkClr : mainColor,
              size: 25.0,
            ),
          ),
          onChanged: (int? value) {
            setState(() {
              radioContainerIndex = value!;
              changeColors = !changeColors;
              controller.updatePosition();
            });
          },
        ), ),

      ],
    );
  }

  Widget buildRadioContainer({
    required Color color,
    required int value,
    required Function onChanged,
    required String name,
    required String title,
    required String phone,
    required String address,
    required Widget icon,
    required double width
  }) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3.0,
            blurRadius: 5.0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio(
            value: value,
            groupValue: radioContainerIndex,
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            onChanged: (int? value) {
              onChanged(value);
            },
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextUtils(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  text: title,
                  color: Colors.black,
                  underLine: TextDecoration.none,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextUtils(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  text: name,
                  color: Colors.black,
                  underLine: TextDecoration.none,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      '🇪🇬+02 ',
                      style: TextStyle(color: darkGreyClr),
                    ),
                    TextUtils(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      text: phone,
                      color: Colors.black,
                      underLine: TextDecoration.none,
                    ),
                     SizedBox(
                      width: width,
                    ),
                    SizedBox(
                      child: icon,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextUtils(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  text: address,
                  color: Colors.black,
                  underLine: TextDecoration.none,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
