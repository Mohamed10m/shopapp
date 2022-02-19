class HomeModel {
  bool? status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<Banners> banners = [];
  List<Products> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((v) {
        products.add(Products.fromJson(v));
      });
    }
  }
}

class Banners {
  late final id;
  late String image;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products {
  late int id;
  late final price;
  late final oldPrice;
  int? discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
