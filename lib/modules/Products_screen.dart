import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubut/shop_layout_cubit.dart';
import 'package:shop_app/layout/cubut/shop_layout_states.dart';
import 'package:shop_app/models/categores_model.dart';
import 'package:shop_app/models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null &&
                  ShopCubit.get(context).categoriesModel != null,
              builder: (context) => builderWidget(
                  ShopCubit.get(context).homeModel!,
                  ShopCubit.get(context).categoriesModel!,
                  context),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }
}

Widget builderWidget(
        HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners
                .map((e) => Image(
                      image: NetworkImage('${e.image}'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ))
                .toList(),
            options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10.0,
                          ),
                      itemCount: categoriesModel.data.data.length),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.50,
              children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context)),
            ),
          )
        ],
      ),
    );

Widget buildCategoryItem(DataModel model) => Container(
      width: 120,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            fit: BoxFit.cover,
          ),
          Container(
            width: 120.0,
            color: Colors.black87.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                model.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

Widget buildGridProduct(Products model, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  height: 15,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 11.0, color: Colors.white),
                    ),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.3, fontSize: 12.0),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(fontSize: 12.0, color: Colors.blue),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavourite(model.id);
                      },
                      icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              ShopCubit.get(context).favourites[model.id]!
                                  ? Colors.red
                                  : Colors.lightBlue,
                          child: Icon(
                            Icons.favorite_outline,
                            size: 14,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
