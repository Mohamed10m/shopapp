import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginSuccessStates extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessStates(this.loginModel);
}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginErrorStates extends ShopLoginStates {}

class ShopChangePasswordStates extends ShopLoginStates {}
