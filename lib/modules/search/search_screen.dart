import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/search_model.dart';
import 'package:shop_app/modules/search/cubit_search/cubit_search.dart';
import 'package:shop_app/modules/search/cubit_search/states_search.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../layout/shop_app/cubit/shop_cubit.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                        TextEditingController: searchController,
                        TextInputType: TextInputType.text,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Must search for something';
                          }
                          return null;
                        },
                        onSubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        label: 'Search',
                        prefix: Icons.search),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoading) const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSuccess)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildFavItem(
                              SearchCubit.get(context).model.data!.data![index],
                              context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .model
                              .data!
                              .data!
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

  Widget buildFavItem(Product? model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.bottomLeft, children: [
                Image(
                  image: NetworkImage(model!.image!),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  )
              ]),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      model!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, height: 1.3),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price.round()}',
                          style: const TextStyle(
                              fontSize: 12, color: defaultColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id!);
                            print(model.id);
                            print(ShopCubit.get(context).favorites![model.id]);
                            print(ShopCubit.get(context).favModel?.status);
                            print(ShopCubit.get(context).favModel?.message);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                (ShopCubit.get(context).favorites![model.id] ??
                                        false)
                                    ? defaultColor
                                    : Colors.grey,
                            child: const Icon(Icons.favorite_border,
                                size: 14, color: Colors.white),
                          ),
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
}
