import 'package:e_commerce/logic/controllers/auth_controller.dart';
import 'package:e_commerce/utils/inputs_rules.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/auth/auth_button.dart';
import 'package:e_commerce/view/widgets/auth/auth_text_form_field.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var switchColorText = Get.isDarkMode ? mainColor : pinkClr;

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
        title: TextUtils(
            text: 'Forgot Password',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? pinkClr : white),
      ),
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'If you want to recover your account, then please provide your email ID below..',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Get.isDarkMode ? darkGreyClr : white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'images/forgetpass copy.png',
                    width: 300,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AuthTextFormField(
                    controller: emailController,
                    obscureText: false,
                    validator: (value) {
                      if (value.toString().length < 2 ||
                          !RegExp(validationEmail).hasMatch(value)) {
                        //kullanici tarafindan girilen value/email Regular Expression kurallarina esit degilse(!) demeki yanlis ve ve Form widgeti ve icndeki key ozelligi sayesinde TextField altinda hata cikack
                        return 'Enter valid Email';
                      }
                    },
                    prefixIcon: Get.isDarkMode
                        ? const Icon(
                            Icons.email,
                            color: pinkClr,
                            size: 27.0,
                          )
                        : const Icon(
                            Icons.email,
                            color: mainColor,
                            size: 27.0,
                          ),
                    hintText: 'Email',
                    suffixIcon: const Text(''),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  GetBuilder<AuthController>(builder: (_) {
                    return ElevatedAuthButton(
                      text: 'SEND',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          //trim() The string without any leading and trailing whitespace.yani solda veya sagda boslukl varsa onu kaldir ve deam et
                          String email = emailController.text.trim();
                          controller.resetPassword(email: email);
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
          )),
    );
  }
}
