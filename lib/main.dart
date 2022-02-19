import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubut/shop_layout_cubit.dart';
import 'package:shop_app/layout/cubut/shop_layout_states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/onBoardig_screen.dart';
import 'package:shop_app/shared/endpoint/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  Widget widget;

  bool? onBoarding = CacheHelper.getData('onBoarding');

  token = CacheHelper.getData('token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavourites()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      fontFamily: 'Signika')),
            ),
            debugShowCheckedModeBanner: false,
            home:OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
