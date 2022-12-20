import 'package:e_commerce/logic/controllers/auth_controller.dart';
import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayMentMethodWidget extends StatefulWidget {
  const PayMentMethodWidget({Key? key}) : super(key: key);

  @override
  State<PayMentMethodWidget> createState() => _PayMentMethodWidgetState();
}

class _PayMentMethodWidgetState extends State<PayMentMethodWidget> {
  //final payMentController = Get.find<PayMentController>();
  final cartController = Get.find<CartController>();
  final authController = Get.find<AuthController>();
  int radioPaymentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildRadioPayment(
    name: "Paypal",
    image: 'images/paypal.png',
    scale: 0.6,
    value: 1,
    onChange: (int? value) {//(){} onChange ozelligi parametre olarak atmadan bu  parantezleri koymazsak baya sikinti yasariz
    setState(() {
    radioPaymentIndex = value!;

    });    // payMentController.removeGooglePay();
    },
        ), const SizedBox(
          height: 10,
        ),
        buildRadioPayment(
          name: "Google pay",
          image: 'images/google.png',
          scale: 0.8,
          value: 2,
          onChange: (int? value) {//(){} onChange ozelligi parametre olarak atmadan bu  parantezleri koymazsak baya sikinti yasariz
            setState(() {
              radioPaymentIndex = value!;

            });    // payMentController.removeGooglePay();
          },
        ), const SizedBox(
          height: 10,
        ),
        buildRadioPayment(
          name: "Paypal",
          image: 'images/credit.png',
          scale: 0.7,
          value: 3,
          onChange: (int? value) {//(){} onChange ozelligi parametre olarak atmadan bu  parantezleri koymazsak baya sikinti yasariz
            setState(() {
              radioPaymentIndex = value!;

            });    // payMentController.removeGooglePay();
          },
        ),
      ],
    );
  }

  Widget buildRadioPayment({
    required String image,
    required double scale,
    required String name,
    required int value,
    required Function onChange,
}) {
    return Container(
      height:50.0 ,
      width: double.infinity,
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  scale: scale,//bazi fotolar boyutlari ayni degil oYuzden biz scale ozelligi ile ayni boyut verebilirz
                ),
                const SizedBox(
                  width: 10,
                ),
                TextUtils(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  text: name,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Radio(
            value: value,
            groupValue: radioPaymentIndex,
            fillColor: MaterialStateColor.resolveWith((states) => mainColor),
            onChanged: (int? value) {
              onChange(value);
              print(value);
            },
          ),

        ],
      ),
    );
  }
}
