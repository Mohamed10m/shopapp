class FavoriteGetModel {
  late bool status;
  late Data data;

  FavoriteGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late int currentPage;
  List<DataItem> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataItem.fromJson(element));
    });
  }
}

class DataItem {
  late int id;
  late Product product;

  DataItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  dynamic price;
  dynamic oldPrice;
  late int discount;
  late String image;
  late String name;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
