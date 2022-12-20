import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeList extends StatefulWidget {
  const SizeList({Key? key}) : super(key: key);

  @override
  State<SizeList> createState() => _SizeListState();
}

class _SizeListState extends State<SizeList> {
  final List<String> sizeList = ['S', 'M', 'L', 'XL', 'XXL'];
  var currentSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,//ekranda cikacak liste satir veya yan yana olarak gozuksun
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                currentSelected=index;//buttoni basinca size'in indexi int olarak cureent degiskene atiyoz baska yerlerde bool degeri gondermek icin kullanacz
              //deisken degeri deigsince bool degeri dondureck ve renk degisir onu setState ile gerceklestirebiliriz
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Get.isDarkMode//burda ic ice if else sayilir
                      ? currentSelected == index//buttoni bastiktan sonra urun boyutunu index curren degiskene atilack ve burda eger run index cureent deigskene esitse true dondur ve secli renk goster diger urunler otomatik farkli olack
                          ? pinkClr.withOpacity(0.4)//eger darkMod secili ise ve curren degiskeni indexe esitse arka renk pink olsun
                          : Colors.black
                      : currentSelected == index //eger darkMod secili degilse ve current degisken indexe esitse*(sectigimiz boyut) ekrandak' size arka rengi yesil olsun
                          ? mainColor.withOpacity(0.4)
                          : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.withOpacity(0.4)),
                ),
                child: Text(
                  sizeList[index],
                  style: TextStyle(
                    color: Get.isDarkMode//eger darkMod secili ise ve item secili ise text regi beyaz olsun
                        ? currentSelected == index//(current==inedx)secili item anlamina gelir
                        ? Colors.white
                        : Colors.white
                        : currentSelected == index//darkMod secili degilse ve item secili ise text rengi siyah olsun
                        ? Colors.black
                        : Colors.black,//darkMod secili degilse ve item seili degilse yinede text rengi siyah olsun
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
          itemCount: sizeList.length),
    );
  }
}
