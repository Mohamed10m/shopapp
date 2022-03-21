import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubut/shop_layout_states.dart';
import 'package:shop_app/models/categores_model.dart';
import 'package:shop_app/models/change_favourite_model.dart';
import 'package:shop_app/models/favourite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/Categories_Screen.dart';
import 'package:shop_app/modules/Products_screen.dart';
import 'package:shop_app/modules/favorites_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/shared/endpoint/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopAppInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(path: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favourites.addAll({element.id: element.inFavorites});
      });
      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      emit(ShopErrorHomeDataStates());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(path: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoryStates());
    }).catchError((error) {
      emit(ShopErrorCategoryStates());
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;

  void changeFavourite(int productId) {
    favourites[productId] = !favourites[productId]!;

    emit(ShopChangeFavouritesStates());

    DioHelper.postData(path: FAVORITE, token: token, data: {
      'product_id': productId,
    }).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);

      if (!changeFavouritesModel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavourites();
      }
      emit(ShopSuccessChangeFavouritesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorChangeFavouritesStates());
    });
  }

  FavoriteGetModel? favoriteGetModel;

  void getFavourites() {
    emit(ShopLoadingGetFavouritesStates());

    DioHelper.getData(path: FAVORITE, token: token).then((value) {
      emit(ShopSuccessGetFavouritesStates());

      favoriteGetModel = FavoriteGetModel.fromJson(value.data);

      emit(ShopSuccessGetFavouritesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouritesStates());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() async {
    await DioHelper.getData(path: PROFILE, token: token).then((value) async {
      userModel = await ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataStates(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataStates());
    });
  }

  void updateData(
      {required String name,
      required String email,
      required String phone}) async {
    emit(ShopLoadingUpdateUserDataStates());

    await DioHelper.putData(
        path: UPDATE,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone}).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserDataStates(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataStates());
    });
  }
}
