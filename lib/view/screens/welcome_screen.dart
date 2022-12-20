import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        //foto ustunde Text koyacagimiz icin Stack kullanacz
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/background.png'))),
          ),
          Container(
            width: double.infinity,
            color: Colors.white.withOpacity(0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                    color: Colors.black.withOpacity(0.4),
                    alignment: Alignment.center,
                    height: 60.0,
                    width: 190.0,
                    child: const TextUtils(
                      text: 'Welcome',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    )),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                    color: Colors.black.withOpacity(0.4),
                    alignment: Alignment.center,
                    height: 60.0,
                    width: 230.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                         TextUtils(
                          text: 'Joseph',
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: mainColor,

                        ),
                         TextUtils(
                          text: '   Shop',
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,

                        ),
                      ],
                    )),
                const SizedBox(
                  height: 300.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.LoginScreen);
                  },
                  child:  const Padding(padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child:const TextUtils(
                      text: "Get Start",
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.0)),
                  height: 50.0,
                  width: 330.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextUtils(
                          text: "Don't have an Account?",
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                         ),
                      TextButton(
                          onPressed: () {
                            Get.offNamed(Routes.SignUpScreen);//ofNamed yazinca welcome sayfasini siliyo ve appBar'da arrowBack kaldiriyo
                          },
                          child: const TextUtils(
                            text: 'Sign UP',
                            fontSize: 25.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            underLine: TextDecoration.underline,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
