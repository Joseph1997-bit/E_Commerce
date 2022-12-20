/*
retrive the user information using the GraphAPI
fields string of fields like birthday,email,hometown
The facebook SDK will return a JSON like
{
"name": "Open Graph Test User",
"email": "open_jygexjs_user@tfbnw.net",
"picture": {
"data": {
"height": 126,
"url": "https://scontent.fuio21-1.fna.fbcdn.net/v/t1.30497-1/s200x200/84628273_176159830277856_972693363922829312_n.jpg",
"width": 200
}
},
"id": "136742241592917"
}*/

//FaceBook girisi sagladiktan sonra alacgimiz bilgi json olark ve hepsi Strin tipi oYuzden degiskenleri String olark tanimladik
import 'dart:convert';

class FaceBookModel {
  final String? name;
  final String? email;
  final String? id;
  final FaceBookPhotoModel? faceBookPhotoModel;
  FaceBookModel({this.name, this.email, this.id, this.faceBookPhotoModel});
  //fackbook ile giris yaptiktan sonra facebook'ta kullanici'min bilgileri(foto,name,email) alip bu uygulamada/shopApp kullanmak icin asgadaki methodlari kullanacz
  factory FaceBookModel.fromJson(Map<String, dynamic> jsonData) =>//fromJson demeki json'dan bilgi ve onun tipi map ve map'in adi jsonData ve bu map'in anahtari ve valusesu asgadki gibi olack
      FaceBookModel(
        email: jsonData['email'],
        id: jsonData['id'],
        name: jsonData['name'],
        faceBookPhotoModel: FaceBookPhotoModel.fromJson(
          jsonData['picture']['data'],//fotonun bilgileri json'da picture icinde sonra data icnde diger bilgiler bu sekilde json'dan cagiriyoz
        ),
      );
}

class FaceBookPhotoModel {
  //json'dan foto almak icin ayri bi class olusturyoruz
  final String? url; //photo String olarak url degiskene atilack
  final int? height; //fotonun boyutu width ve height ile belirliyoz
  final int? width;
  FaceBookPhotoModel({this.url, this.height, this.width});
  //In Dart, we use the factory keyword to identify a default or named constructor. We use the factory keyword to implement constructors that do not produce new instances of an existing class.
  //A factory constructor can return a value from a cache(yani gizli yerde saklanan şey)or a sub-type instance yani alt tür örneği.normalde json ile kullanilir baska yerden bilgi almak icin
  factory FaceBookPhotoModel.fromJson(Map<String, dynamic> jsonData) =>
      FaceBookPhotoModel(
          url: jsonData['url'],
          width: jsonData['width'],
          height: jsonData['height']);
}
