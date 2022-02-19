import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubut/shop_layout_cubit.dart';
import 'package:shop_app/layout/cubut/shop_layout_states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {

    }, builder: (context, state) {
      var fomKey = GlobalKey<FormState>();
      var model = ShopCubit.get(context).userModel!.data;
      nameController.text = model!.name!;
      emailController.text = model.email!;
      phoneController.text = model.phone!;
      return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: fomKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        defaultFormField(
                            controller: nameController,
                            label: 'Name',
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'name must not be empty ';
                              }
                            },
                            prefix: Icons.person),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'email must not be empty ';
                              }
                            },
                            prefix: Icons.email),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            label: 'Phone',
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'phone must not be empty ';
                              }
                            },
                            prefix: Icons.phone),
                        SizedBox(
                          height: 20,
                        ),
                        defaultMaterialButton(
                            text: 'update',
                            isUpperCase: true,
                            onPressed: () {
                              if (fomKey.currentState!.validate())
                                ShopCubit.get(context).updateData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultMaterialButton(
                            text: 'logout',
                            isUpperCase: true,
                            onPressed: () {
                              CacheHelper.removeData('token').then((value) {
                                if (value) {
                                  navigateAndFinish(context, ShopLoginScreen());
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()));
    });
  }
}
