import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopAppInitialStates extends ShopStates {}

class ShopLoadingHomeDataStates extends ShopStates {}

class ShopSuccessHomeDataStates extends ShopStates {}

class ShopErrorHomeDataStates extends ShopStates {}

class ShopSuccessCategoryStates extends ShopStates {}

class ShopErrorCategoryStates extends ShopStates {}

class ShopSuccessChangeFavouritesStates extends ShopStates {}

class ShopErrorChangeFavouritesStates extends ShopStates {}

class ShopChangeFavouritesStates extends ShopStates {}

class ShopSuccessGetFavouritesStates extends ShopStates {}

class ShopLoadingGetFavouritesStates extends ShopStates {}

class ShopErrorGetFavouritesStates extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopSuccessGetUserDataStates extends ShopStates {
  final ShopLoginModel loginModel;
  ShopSuccessGetUserDataStates(this.loginModel);
}

class ShopErrorGetUserDataStates extends ShopStates {}

class ShopSuccessUpdateUserDataStates extends ShopStates {
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserDataStates(this.loginModel);
}

class ShopLoadingUpdateUserDataStates extends ShopStates {}

class ShopErrorUpdateUserDataStates extends ShopStates {}
