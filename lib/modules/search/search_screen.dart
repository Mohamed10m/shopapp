import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var formKey = GlobalKey<FormState>();
          var searchController = TextEditingController();

          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (String text) {
                        SearchCubit.get(context).Search(text);
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'search', prefixIcon: Icon(Icons.search)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is SuccessSearchStates)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildListItem(
                                SearchCubit.get(context)
                                    .model!
                                    .data
                                    .data[index]),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 20),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data
                                .data
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildListItem(Product model) => Padding(
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
                  Text(
                    model.price!.toString(),
                    style: TextStyle(fontSize: 12.0, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
