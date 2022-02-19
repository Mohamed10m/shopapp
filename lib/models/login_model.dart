class ShopLoginModel {
  bool? status;
  String? message;
  Data? data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? name;
  String? email;
  String? phone;
  String? token;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
  }
}
