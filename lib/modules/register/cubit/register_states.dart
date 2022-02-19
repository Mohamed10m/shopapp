import 'package:shop_app/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}

class ShopRegisterSuccessStates extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSuccessStates(this.loginModel);
}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterErrorStates extends ShopRegisterStates {}

class ShopRegisterChangePasswordStates extends ShopRegisterStates {}
