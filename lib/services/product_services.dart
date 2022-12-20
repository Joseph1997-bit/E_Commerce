import 'dart:convert';
import 'package:e_commerce/utils/inputs_rules.dart';
import 'package:http/http.dart' as http;//as http demeki http paketin icindeki methodlari(get,Response) bu kelime(hattp) kullanark ulasabiliriz boylece daha kolay ve aciklayici olur

class ProductServices{

 static Future getProduct() async {
   var uri = Uri.parse('$baseUrl/products');
var response=await http.get(uri);

if(response.statusCode ==200) {
var jsonData=response.body;//response.body demek sitede tum bilgiler al ve jsonData'ya ver.url kullanark http get request/istek aliyoz jsondan/baska yerden bilgi almak icin
//JOSN'dan aldigmiz (response body,yanıt organı,هيئة الاستجابة) degleri degiskene atip rahatca yazabilirz
return jsonDecode(jsonData); //sonra response olark alidgimiz bilgi/cevap jsonDecod/kod cozucu ile istedigmiz bilgiyi alabilriz
}//ve en son bu method Api'den json olarak bir suru product/urun donduren bi method oldu sonra bi degiskene atip istedigmiz yerde kullanabilrz
else {
  return throw Exception('Failed to load product');
}

  }
}