import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubut/shop_layout_cubit.dart';
import 'package:shop_app/layout/cubut/shop_layout_states.dart';
import 'package:shop_app/models/favourite_model.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).favoriteGetModel != null,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildFavItem(
                    ShopCubit.get(context)
                        .favoriteGetModel!
                        .data
                        .data[index]
                        .product,
                    context),
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemCount:
                    ShopCubit.get(context).favoriteGetModel!.data.data.length),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget buildFavItem(Product model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        width: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
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
            SizedBox(
              width: 30.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3, fontSize: 12.0),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price!.toString(),
                        style: TextStyle(fontSize: 12.0, color: Colors.blue),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice!.toString(),
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
                            backgroundColor: Colors.red,
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
            ),
          ],
        ),
      ),
    );
