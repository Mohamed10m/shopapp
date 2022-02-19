class SearchModel {
  late bool status;
  late Data data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late int currentPage;
  List<Product> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Product.fromJson(v));
      });
    }
  }
}

class Product {
  dynamic id;
  dynamic price;
  late String image;
  late String name;
  late String description;
  List<String> images = [];
  late bool inFavorites;
  late bool inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
