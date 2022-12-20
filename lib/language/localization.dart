

import 'package:e_commerce/language/ar.dart';
import 'package:e_commerce/language/en.dart';
import 'package:e_commerce/language/tur.dart';
import 'package:e_commerce/utils/inputs_rules.dart';
import 'package:get/get.dart';

class LocaliztionApp extends Translations {
  @override
  //1. Map anhatari String tipi olacak bu anahtarinin deger Map olacak ve bu Map icinde yinede anahtar/key ve deger/value var
  Map<String, Map<String, String>> get keys => {
    ene: en,//anahtar/key deger string olarak atilack (ene=en) ve bu anahtarinin degeri/value Map turunden olack
    ara: ar,//yani daha once ayri dart sayfalarinda(ar,en,tr)Map olarak olusturdugumz dilleri calistirp ekranda gorecz
    trt:tr
  };
}