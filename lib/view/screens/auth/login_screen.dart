import 'package:e_commerce/logic/controllers/auth_controller.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/utils/inputs_rules.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/auth/auth_button.dart';
import 'package:e_commerce/view/widgets/auth/auth_text_form_field.dart';
import 'package:e_commerce/view/widgets/auth/bottom_container.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
//Get paketi kullanarki veGetPage binding ozellige bu classi attik AuthController classi ve icindeki methodulari bu sayfada kullanmk icin bu sekilde bulup cagiriyoz
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Get.isDarkMode ekranin rengi degistirmek icin kullanilir bool deger alir ve Get paket'in icnde olur
      backgroundColor: context.theme.backgroundColor, //eger darkModi secili ise yani dogru ise white gosterck degilse siyah gosterck ve boylece
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ?  darkGreyClr:white ,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    TextUtils(
                      text: 'LOG ',
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ?  pinkClr: mainColor,
                    ),
                    TextUtils(
                      text: 'IN',
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? white : darkGreyClr,
                    )
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                AuthTextFormField(
                  controller: emailController,
                  obscureText: false,
                  validator: (value) {
                    if (value.toString().length < 2 ||
                        !RegExp(validationEmail).hasMatch(value)) {
                      //kullanici tarafindan girilen value/email Regular Expression kurallarina esit degilse(!) demeki yanlis ve su islemi yap
                      return 'Enter valid Email';
                    }
                  },
                  prefixIcon: Get.isDarkMode
                      ? const Icon(
                          Icons.email,
                          color:pinkClr ,
                          size: 27.0,
                        )
                      : const Icon(
                          Icons.email,
                          color:mainColor ,
                          size: 27.0,
                        ),
                  hintText: 'Email',
                  suffixIcon: const Text(''),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                GetBuilder<AuthController>(builder: (_) {
                  //TextField icinde controller cagirip ekranda degismeleri gormek/gostermek  icin GetBuilder widgeti icinde koymamiz lazim ve turu belirlemiz lazim
                  return AuthTextFormField(
                    controller: passwordController,
                    obscureText: controller.isVisibilty ? true : false,
                    validator: (value) {
                      if (value.toString().length < 6) {
                        return 'Password should be longer or equal to 6 characters';
                      }
                    },
                    prefixIcon: Get.isDarkMode
                        ? const Icon(
                      Icons.lock,
                      color: pinkClr,
                      size: 27.0,
                    )
                        : Image.asset('images/lock.png'),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.visibility();
                        },
                        icon: Icon(
                          controller.isVisibilty
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: darkGreyClr,
                        )),
                  );
                }),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes
                          .ForgotPasswordScreen); //offNamed yazarsak diger sayfada Get back yazsak bile calismaz cunku off methodu onceki sayfayi siliyo
                    },
                    child: TextUtils(
                        text: 'Forgot Password',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ?pinkClr:mainColor ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                GetBuilder<AuthController>(builder: (_) {
                  return ElevatedAuthButton(
                    text: 'LOG IN',
                    onPressed: () {
                      //formKey degiskeni kullanark butun TextField'lar uygun bi sekilde doldurduktan yani hata/eksik yoksa oZaman firebase islemini devam etsin
                      if (formKey.currentState!.validate()) {
                        //trim() The string without any leading and trailing whitespace.yani solda veya sagda boslukl varsa onu kaldir ve deam et
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        controller.logInUsingFirebase(
                            email: email, password: password);
                      }
                    },
                  );
                }),
                const SizedBox(
                  height: 20.0,
                ),
                TextUtils(
                    text: 'OR',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ?white  :darkGreyClr ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<AuthController>(builder: (_) {
                      return InkWell(
                          onTap: () {
                            controller.faceBookSignUpApp();
                          },
                          child: Image.asset('images/facebook.png'));
                    }),
                    const SizedBox(
                      width: 25.0,
                    ),
                    GetBuilder<AuthController>(builder: (_) {
                      return InkWell(
                          onTap: () {
                            controller.googleSignUpApp();
                          },
                          child: Image.asset('images/google.png'));
                    })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomContainer(
        //TextField'a basinca bu container ekran/keyboard ile beraber cikmamak icin bottomNavigationBar ozelligi kullandim
        text: 'Dont\' have an Account?',
        onPressed: () {
          Get.offNamed(Routes.SignUpScreen);
        },
        buttonTitle: 'Sign Up',
      ),
    );
  }
}
