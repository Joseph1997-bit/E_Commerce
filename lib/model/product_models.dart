
import 'dart:convert';

//**************************
//[NOT]onemli :Api'dan json olark bilgil almak icin ve ekranda gostermek icin burda bi suru class ve degisken yazmak yerine Angela kursunda ogrendigmiz yolu daha kisa ve kolay kullandim
//****************************

/*
List<ProductModel> productModelsFromJson(String str) =>
    List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x),
        ));


String welcomeToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(
      data.map(
        (x) => x.toJson(),
      ),
    ));


class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final Category? category;
  final String image;
  final Rating rating;

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) => ProductModel(
        id: jsonData["id"],
        title: jsonData["title"],
        price: jsonData["price"].toDouble(),
        description: jsonData["description"],
        category: categoryValues.map![jsonData["category"]],
        image: jsonData["image"],
        rating: Rating.fromJson(jsonData["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": categoryValues.reverse![category],
        "image": image,
        "rating": rating.toJson(),
      };


}


enum Category {
  MEN_S_CLOTHING,
  JEWELERY,
  ELECTRONICS,
  WOMEN_S_CLOTHING
} //enum tipinden olusan class'i kullanark icndekilere direk olasabilirz

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});

class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  final double rate;
  final int count;

  factory Rating.fromJson(Map<String, dynamic> jsonData) => Rating(
        rate: jsonData["rate"].toDouble(),
        count: jsonData["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map?.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

*/
