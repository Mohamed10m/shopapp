import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/register/rejgister_screen.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/endpoint/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
        if (state is ShopLoginSuccessStates) {
          if (state.loginModel.status!) {
            CacheHelper.saveData('token', state.loginModel.data!.token)
                .then((value) {
              token = state.loginModel.data!.token;
              showToast(
                  text: state.loginModel.message!, state: ToastStates.SUCCESS);
              navigateAndFinish(context, ShopLayout());
            });
          } else {
            showToast(
                text: state.loginModel.message!, state: ToastStates.ERROR);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                        controller: emailController,
                        validate: (String? value) {
                          if (value!.isEmpty)
                            return 'email address must not be empty';
                        },
                        prefix: Icons.email,
                        label: 'Email Address',
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'password must not be empty';
                          }
                        },
                        prefix: Icons.lock,
                        suffix: ShopLoginCubit.get(context).suffix,
                        suffixPressed: () {
                          ShopLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        obSecureText: ShopLoginCubit.get(context).isPassword,
                        label: 'Password',
                        type: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      ConditionalBuilder(
                          condition: state is! ShopLoginLoadingStates,
                          builder: (context) => defaultMaterialButton(
                              text: 'login',
                              isUpperCase: true,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator())),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              child: Text('Register'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
