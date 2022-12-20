import 'package:e_commerce/model/facebokk_model.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isSignIn=false;//google veya facebook ile giris yaptiktan sonra degeri true yapip authBoxStorage.write('auth', isSignIn)'fonksuonuna atacz girisi kaydEtmek icin Storage'ta write methodu ile
  final GetStorage authBoxStorage=GetStorage();
  bool isVisibilty = false;
  bool isCheckBox = false;
  final _auth = FirebaseAuth.instance;
  var displayUserName = ''.obs;
  var displayUserPhoto = ''.obs;
  var displayUserEmail = ''.obs;
  FaceBookModel? faceBookModel; //faceBook sayfasinda olusturdugmuz FaceBookModel class'tan bi degisken olusturyoz farkli yerlerde kullanmak icin

  User? get userProfile => _auth.currentUser;
  @override
  void onInit() {//initState gibi calisir ve icindki metodlari calistirir
    //google girisi firebase sitesinde kayit etikten sonra bu sekilde bilgileri(adi,email,photo) cagirp onInit method ile ekranda direkt gosterebiliriz
    displayUserName.value = (userProfile != null ? userProfile!.displayName : "")!;
    displayUserPhoto.value = (userProfile != null ? userProfile!.photoURL : "")!;
    displayUserEmail.value = (userProfile != null ? userProfile!.email : "")!;
    super.onInit();
  }



  //GetBuilder kolay islemler  degiskenler degeri degisince gibi kullanilir ve update methodu kullanilir ve daha hizli
//Obx Stream islemler icin kullanilir
  void visibility() {
    isVisibilty = !isVisibilty;
    update(); //update fonks notifierlistener ve setState gibi degiskenin degeri degisince ve onu ekranda gostermek icin aninda degismeleri gormek icin onu kullaniyoz Get ile
  }

  void checkBox() {
    isCheckBox = !isCheckBox;
    update();
  }

  Future<void> signUpUsingFirebase({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      //flutterFire sayfasinda registration ve signIn icin hazir kodlar verilims
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayUserName.value = name;
        _auth.currentUser!.updateDisplayName(name);
        //disPlayUserName = _auth.currentUser!.updateDisplayName(name) as String;boyle yazarsak null ile ilgili hata aliriz
      }); //password ve email ekledikten sonra then kelimesi ile _auth.currentUser adini bu sekilde ekleyebilirz
      update();
      Get.offNamed(Routes.MainScreen);
    } on FirebaseAuthException catch (e) {
      //fireBase tarafindan verilen hazir error mesajlari ve onlari kullanmak icin on FirebaseAuthException yazmamz lazim sonra (kod,mesaj..),gibi degiskenler kullanbilrz
      String? title = e
          .message; //firebasr'ten verilen error mesaji title degiskene atip gostercz
      //String title=e.code.replaceAll('-', ''); //ekranda cikan bazi karakterler kaldirip onun yerine bosluk yada baska bi sey koymak icin replaceAll methodu kullanabilirz
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Please try again.';
      } else {
        message = e.message
            .toString(); //eger firebasetan gelen baska bi hata varsa onuda yazdir
      }

      //atalari kullanicilara gostermek icin Get paketi kullanacz cunku bize hazir bi snackbar sagliyor
      Get.snackbar(
        title!,
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: mainColor,
        colorText: darkGreyClr,
        icon: const Icon(Icons.error),
        snackStyle: SnackStyle.FLOATING,
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(20.0),
        duration: const Duration(seconds: 3),
      );
    } catch (error) {
      //eger firebase tanimadigi bi hata/error varsa burda bulup yzdiracagiz
      Get.snackbar(
        'Error',
        '${error}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: white,
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 10),
      );
    }
  }

  Future<void> logInUsingFirebase({
    required String email,
    required String password,
  }) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayUserName.value = _auth.currentUser!.displayName!;
      }); //password ve email ekledikten sonra then kelimesi ile _auth.currentUser.displayName adini bu sekilde alabilirz/gosterebilirz;
      update();
      Get.offNamed(Routes.MainScreen);
    } on FirebaseAuthException catch (e) {
      //fireBase tarafindan verilen hazir error mesajlari ve onlari kullanmak icin on FirebaseAuthException yazmamz lazim sonra (kod,mesaj..),gibi degiskenler kullanbilrz
      String? title = e
          .message; //firebasr'ten verilen error mesaji title degiskene atip gostercz
      String message = '';
      if (e.code == 'user-not-found') {
        message =
            'Account does not exists for that $email.. Create your account by signing up...';
      } else if (e.code == 'wrong-password') {
        message = 'Invalid Password... PLease try again!';
      } else {
        message = e.message
            .toString(); //eger firebasetan gelen baska bi hata varsa onuda yazdir
      }

      Get.snackbar(
        title!,
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: mainColor,
        colorText: darkGreyClr,
        icon: const Icon(Icons.error),
        snackStyle: SnackStyle.FLOATING,
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(20.0),
        duration: const Duration(seconds: 3),
      );
    } catch (error) {
      //eger firebase tanimadigi bi hata/error varsa burda bulup yzdiracagiz
      Get.snackbar(
        'Error',
        '$error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: white,
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 10),
      );
    }
  }

  Future<void> googleSignUpApp() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      //GoogleSignIn().signOut();
      displayUserName.value = googleUser!.displayName!;
      displayUserPhoto.value = googleUser.photoUrl!; //photoUrl tipi String
      displayUserEmail.value = googleUser.email;


      GoogleSignInAuthentication googleSignInAuthentication =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
        await _auth.signInWithCredential(credential);//firebase sitesinde users kismina eklemek icin bu methodu kullandik

      isSignIn=true;//giris yaptiktan sonra SignIn degeri true yapip write fonksyonuna atiyoz kaydEtmek icin
      authBoxStorage.write('auth', isSignIn);
      update();
      Get.offNamed(Routes.MainScreen);
    } catch (error) {
      //eger firebase tanimadigi bi hata/error varsa burda bulup yzdiracagiz
/*  Get.snackbar(
    'Error',
    '$error',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.blue,
    colorText: white,
    icon: const Icon(Icons.error),
    duration: const Duration(seconds: 3),
  );*/
      print(error);
    }
  }

//For Generating keyhash for facebook developer.Don't use the terminal inside the Visual Studio Code or Android Studio, use PowerShell or a standard Command Prompt.and write the kod in the stackover.
  Future<void> faceBookSignUpApp() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      //eger login islemi dogru olursa asgadki islemleri yap
      final data = await FacebookAuth.instance
          .getUserData(); //kullanicin bilgileri alacz,name,email,photo,.. ve getUserData methodu Future Map<String, dynamic> bi deger donduryo ama json olark
      //ve bu sekilde kullanicin bilgilleri json olark alip data degiskene atiyoz
      faceBookModel = FaceBookModel.fromJson(data); //bilgileri getUserData sayesinde aldiktan sonra map ve json olarak FaceBookModel sinifina atioyz ve orda istedigmiz bilgileri map olark alacz cunku json
      Get.offNamed(Routes.MainScreen);
      isSignIn=true;
      authBoxStorage.write('auth', isSignIn);
      update();
      print('*************************\n*=============');
      print(faceBookModel!
          .email); //faceBook kullanicinin bilgileri console'da gormek icin bunlari yazdik
      print(faceBookModel!.id);
      print(faceBookModel!.name);
      print('*************************\n*=============');
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      update();
      Get.back();
    } on FirebaseAuthException catch (e) {
      String? title = e
          .message; //firebasr'ten verilen error mesaji title degiskene atip gostercz
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'Please try again';
      } else {
        message = e.message
            .toString(); //eger firebasetan gelen baska bi hata varsa onuda yazdir
      }
      Get.snackbar(
        title!,
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: mainColor,
        colorText: darkGreyClr,
        icon: const Icon(Icons.error),
        snackStyle: SnackStyle.FLOATING,
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(20.0),
        duration: const Duration(seconds: 3),
      );
    } catch (error) {
      //eger firebase tanimadigi bi hata/error varsa burda bulup yzdiracagiz
      /*     Get.snackbar(
        'Error',
        '${error}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: white,
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 3),
      );*/
      print(
          error); //bazen gereksiz/onemsiz uyarilar/hatalar cikabilir oYuzden kullniciya gostermize gerek yok console'da goresek yeterli
    }
  }

  Future<void> signOutFormApp() async {
    try {
      await _auth.signOut();//signOut islemileri hepsi Future bi deger donduryo oYuzden baska isleme/sayfaya gecmeden once bitmesini beklememiz lazim
    await  GoogleSignIn().signOut();
   await FacebookAuth.instance.logOut();
      displayUserName.value='';
   displayUserPhoto.value='';
   displayUserEmail.value='';
      isSignIn=false;
      authBoxStorage.remove('auth');//cikis yaptiktan sonra giris degerleri siliyoz ve storage methodlari arasinda birbirene baglamak icin key/anahtar degeri String olarak veriyoz
   update();
   Get.offNamed(Routes.welcomeScreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: white,
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 3),
      );
    }
  }
}
