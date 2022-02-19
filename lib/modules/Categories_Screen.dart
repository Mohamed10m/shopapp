import 'dart:ui';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubut/shop_layout_cubit.dart';
import 'package:shop_app/layout/cubut/shop_layout_states.dart';
import 'package:shop_app/models/categores_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).categoriesModel != null,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildCategoryItem(
                      ShopCubit.get(context).categoriesModel!.data.data[index]),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount:
                      ShopCubit.get(context).categoriesModel!.data.data.length),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }
}

Widget buildCategoryItem(DataModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
