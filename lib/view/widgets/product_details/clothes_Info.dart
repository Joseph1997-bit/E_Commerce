import 'package:e_commerce/logic/controllers/product_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:readmore/readmore.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

class ClothesInfo extends StatelessWidget {
  final String title;
  final int productId;
  num rate; //rate deger num tipinden tainmlayip ve RatingBar widgeti kullaninca double'e cevirmemiz lazim
  final String description;
  ClothesInfo(
      {required this.title,
      required this.productId,
      required this.rate,
      required this.description});
  final controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow
                      .ellipsis, //eger urun adi uzun olursa cumlenin sonunda 3 nokta olarak gosterileck ve bu ozellik expaned ile kullanilmali
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? white : darkGreyClr,
                  ),
                ),
              ),
              Obx(() => Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? white.withOpacity(0.9)
                          : darkGreyClr.withOpacity(0.4),
                      shape: BoxShape
                          .circle, //iconu dairew icinide koymak icin shap ozelligi kullandim
                    ),
                    child: InkWell(
                        onTap: () {
                          //buttoni basinca favorit listesine eklencek ve kalp iconu kirmizi olur eger daha once varsa silinir ve icon bos olur
                          controller.manageFavorites(productId);
                        },
                        child: controller.isFavorites(productId)
                            ? const Icon(
                                Icons.favorite,
                                color: red,
                                size: 20.0,
                              )
                            : const Icon(
                                Icons.favorite_outline,
                                color: darkGreyClr,
                                size: 20.0,
                              )),
                  ))
            ],
          ),
          Row(
            children: [
              TextUtils(
                  text: '$rate',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? white : darkGreyClr),
              const SizedBox(
                width: 13.0,
              ),
              SimpleStarRating(
                //bu widget urunun degerlendirmesi yildiz olarak gosterck ve bunu rating ozelligi ile gerceklestirebiliriz
                rating: rate
                    .toDouble(), //num tipinden bi deger alip onu double;e cevirmemiz lazim yoksa deger int tipinden bir urun basarsak hata verir
                filledIcon: Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.orange,
                ),
                starCount: 6, //kac tane yildiz ekranda cikacagini belirleyeck
                spacing:
                    4.0, //spacing ozelligi yildizlar arasindaki bosluk belirliyor
                allowHalfRating:
                    true, //yildiz yarisi dolu olmasina izin  verdik
                onRated: (rating) {},
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          ReadMoreText(
            //ReadeMore widgeti veya paketi aciklama uzun olursa readmore buttoni ekleceyk daha guzel bi tasarim olack
            description,
            //  trimLines: 3,
            trimMode: TrimMode.Line,//bu ozellik aciklamanin yarisini gostereck ve readMore buttoni cikar karsimza
        //    trimLength: 100, //her urunda kelimelerin sayisi belirliyo length/boyut bitince ReadMore buttoni cikack
            textAlign: TextAlign
                .justify, //satirlar veya cumleler yaslanack duzgun olack yani word programdaki gibi
            trimCollapsedText: ' Show More ',
            moreStyle: TextStyle( fontSize: 15,fontWeight: FontWeight.bold,color: Get.isDarkMode?pinkClr:mainColor),//Show more kelimesi icin kullanilir
            trimExpandedText: '  Show Less ',//acilamayi kistlamak icin veya eski haline donmek icin kullanilir
           lessStyle: TextStyle( fontSize: 15,fontWeight: FontWeight.bold,color: Get.isDarkMode?pinkClr:mainColor),//Show less kelimesi icin kullanilir
          ),
        ],
      ),
    );
  }
}
