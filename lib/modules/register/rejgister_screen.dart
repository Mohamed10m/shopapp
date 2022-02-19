import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/endpoint/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var namedController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessStates) {
            if (state.loginModel.status!) {
              CacheHelper.saveData('token', state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                showToast(
                    text: state.loginModel.message!,
                    state: ToastStates.SUCCESS);
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              showToast(
                  text: state.loginModel.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
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
                          controller: namedController,
                          validate: (String? value) {
                            if (value!.isEmpty) return 'name must not be empty';
                          },
                          prefix: Icons.drive_file_rename_outline,
                          label: 'Name',
                          type: TextInputType.name,
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
                          controller: phoneController,
                          validate: (String? value) {
                            if (value!.isEmpty)
                              return 'phone address must not be empty';
                          },
                          prefix: Icons.phone,
                          label: 'Phone',
                          type: TextInputType.phone,
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
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          obSecureText:
                              ShopRegisterCubit.get(context).isPassword,
                          label: 'Password',
                          type: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingStates,
                          builder: (context) => Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: defaultMaterialButton(
                                text: 'Register',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                        name: namedController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text);
                                  }
                                }),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
