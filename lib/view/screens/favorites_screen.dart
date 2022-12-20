import 'package:e_commerce/logic/controllers/product_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);
  final controller = Get.put(
      ProductController()); //GePage() binding ozelligne ProductController sayfasi eklemedigmiz icin put kullanmamiz lazim
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Obx(
        () {
          if (controller.favoritesList.isEmpty) {
            //eger favoritesList bos ise please add product mesajini goster
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("images/heart.png"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please, Add your favorites products.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
                //ListeView.builder gibi calisir ama daha fazla bi ozellik var separatorBuilder ekranda olusturan her widget altinda baska widget olabir yani widgetlari ayrit ediyor
                itemBuilder: (context, index) {
                  return buildFavItems(
                      image: controller.favoritesList[index]['image'],
                      price: controller.favoritesList[index]['price'],
                      title: controller.favoritesList[index]['title'],
                      productId: controller.favoritesList[index]['id']);
                },
                separatorBuilder: (context, index) {
                  //itemBuilder ozelligi gibi calisir ama olusturulan widgetlar altinda olack normalde Divider kullanilir
                  return const Divider(
                    color: gry,
                    thickness: 2,
                  );
                },
                itemCount: controller.favoritesList.length);
          }
        },
      ),
    );
  }

  Widget buildFavItems({
    required String image,
    required var price,
    required String title,
    required int productId,
  }) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 100,
        child: Row(
          children: [
            SizedBox(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: AspectRatio(
                  aspectRatio: 1, //childin/fotu'nun alani/boyutunu buyutebilir
                  child: Image.network(image, fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Get.isDarkMode ? white : darkGreyClr,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow
                            .ellipsis //text'in kapsadigi alani gecerse 3 nokta olarak gosterileck ve cumlenin devamini yazilmazck.ve Expanded ile kullnilirsa daha iyi gozukeck
                        ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '\$ $price',
                    style: TextStyle(
                        color: Get.isDarkMode ? white : darkGreyClr,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow
                            .ellipsis //text'in kapsadigi alani gecerse 3 nokta olarak gosterileck ve cumlenin devamini yazilmazck
                        ),
                  ),
                ],
              ),
            ),

            IconButton(
                onPressed: () {
                  controller.manageFavorites(productId);
                },
                icon: const Icon(
                  Icons.favorite,
                  size: 30,
                  color: red,
                ))
          ],
        ),
      ),
    );
  }
}
