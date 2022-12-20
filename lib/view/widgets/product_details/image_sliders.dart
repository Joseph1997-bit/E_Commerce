import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/product_details/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSliders extends StatefulWidget {
   ImageSliders({required this.imageUrl, Key? key,}) : super(key: key);

  final String imageUrl;
  @override
  _ImageSlidersState createState() => _ImageSlidersState();
}

class _ImageSlidersState extends State<ImageSliders> {
  CarouselController carouselController = CarouselController();

  final cartController = Get.find<CartController>();

  final List<Color> colorList = [
    kCOlor1,//urunler ustunde farkli renkleri gostermek icin Color tipinden ayri bi list olusturyoz ve ListView ile gosterebilirz
    kCOlor2,
    kCOlor3,
    kCOlor4,
    kCOlor5,
    kCOlor2,
    kCOlor3,
    kCOlor4,
  ];
  int currentPage = 0;
  int currentColor = 0;
  @override
  Widget build(BuildContext context) {
    return Stack( //bazi widgetlar fotolar uzerinde olack diye Stack kullandik
      children: [
        CarouselSlider.builder(
          itemCount: 3,
          carouselController: carouselController,//Animate to the next page.yani fotolar arasinda gecis nasil olmali
          options: CarouselOptions(//fotlar arasinda bi suru secenekler var CarouselOptions ile gosterebilirz
              height: 500,
              autoPlay: true,//tek basina fotolari cevireck
              enlargeCenterPage: true,//sagda ve soldaki fotolar boyutu kucuk olack ve ortada cikan foto buyuk olack
              enableInfiniteScroll: false,//false degeri versek fotolar bitince tekrar ceviremeyiz true versek sonsuza kadar cevirebi'rz
              autoPlayInterval: const Duration(seconds: 3),//kac sanye sonra tek basina hareket etsin
              viewportFraction: 1, //ekranda kac tane foto gostereck 1 yazsak sadec 1 tane foto cikack karsimza
              onPageChanged: (index, reson) {
                //foto altinda uc tane nokta var arasinda hareketi gormek icin onPageChanged ozelligi eklemk lazim
                setState(() {
                  currentPage = index;
                });
              }),
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.all(24),//fotolar arasina bosluk olsun diye
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),//statFull icin constructor degiskenleri kullanmak icin widget kelimesi kullanmamiz lazim
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            );
          },
        ),
        Positioned(//ekranda foto altinda hareket eden uc nokta animation tam ortada olsun
          bottom: 30,
          left: 170,
          child: AnimatedSmoothIndicator(//fotolari degistirmek icin  altinda hareket eden noktalar icin bu widget kullandik
            activeIndex: currentPage,//noktalarin isareti hangi gotodan baslasin diye ve onu degistirnce ekranda gormek icin bi degiskene atioz ve setstate ile degismeleri gorebilrz
            count: 3,//foto altinda noktalarin sayisi
            effect: JumpingDotEffect(
              dotHeight: 15,//noktalaron uzunlugu ve genisligi bu ozellklerle belirliyoz
              dotWidth: 15,
              activeDotColor: Get.isDarkMode ? pinkClr : mainColor,
              dotColor: Colors.black, //bos noktalarin rengi
            ),

          ),
        ),

        Positioned(//ekranda gorunun renklerin yerini belirliyoz
          bottom: 40,
          right: 15,
          child: Container(//ekranda gorunen renklerin arka rengi haifi siyah olsun.kucuk serit olark goruneck ve boyutu belirlemk icin containr kullandik
            height: 200,
            width: 50,
            padding: const EdgeInsets.all(8),//daireli renklerin boyutu
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),//ekranda gorunu renklerin şeriti biraz siyah olsun
              borderRadius: BorderRadius.circular(30),//etrafları daireli bir şerit olsun dıye
            ),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(//urun ustunde bi suru farkli dokunmali renkleri gostermek icin GestureDetecor widget icinde daha once tanimladigmiz Containerler ColorPicker koyarz
                  onTap: () {
                    setState(() {
                      //ListView index değişkeni kullanark listdeki renkleri sırayla gösteriyo yani her index bi renk temisl ediyor ve biz currentColor değişkene atınca int olark atıyoz ama renk onu renk olark düşünelim
                      currentColor = index;//color'i tiklayinca rengini indexi currentColor değişkene atıyoz int olark ve bu değişkeni kullanark outBorder özelliğinde bool değei gönderip hangi rengi tıkladığmıza belirlemk için ve ekranda göstermek için

                    });
                  },
                  child: ColorPicker(
                    color: colorList[index],//index'e gore sirayla colorSelected list icnde renkleri gostercz
                   //color'i tiklayinca setState icinde renginin indexi currentColor degiskene atiyoz sonra
                    // outBorder ozelligine bool degeri atmak icin diyoruzki eger index degeri currentColor degiskene esitse(currentColor==index) true gonder degilse false gonderck
                    //ve currentColor int değer kullanark true değer atıp rengini etrafını değşecek ve hangi rengi seçtiğimizi belli olacak
                    outerBorder: currentColor == index,//rengi tiklayinca secili olark gozuksun diye outBorder ozelligi kullanip ve tklayinca index'e gore hangi renk border/etrafi gozuksun
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 3),//renkli Containerleri/widgetlar ayirmaki icin SizedBox kullaniriz
              itemCount: colorList.length,//list icindeki elemanlarin sayisina gore donsun/calissin/ekranda gostersin
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: 25,
            right: 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? pinkClr.withOpacity(0.8)
                        : mainColor.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Get.isDarkMode ? Colors.black : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Badge(//ShopingCart'a basinca ekrada urun ustunde cunku Stack kullandik yukarda sagda ne kadar urun/product eklediysek sayı olarak o kadar gosterileck Icon animation olarak
                  position: BadgePosition.topEnd(top: -10, end: -10),
                  animationDuration: const Duration(milliseconds: 300),
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    cartController.quantity().toString(),//cartList'sinin mikatrini/quantity yani urun sayisin  gostercz
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.CartScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? pinkClr.withOpacity(0.8)
                            : mainColor.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
