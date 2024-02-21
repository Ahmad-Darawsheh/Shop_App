import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/home_model.dart';

import '../../layout/shop_app/cubit/shop_cubit.dart';
import '../../layout/shop_app/cubit/shop_states.dart';
import '../../models/shop_app/favorites_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder:(context)=> ListView.separated(
              itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).getFavModel?.data?.data[index].product,context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit.get(context).getFavModel!.data!.data.length),
          fallback:(context)=>const CircularProgressIndicator(),
          condition: state is! LoadingFavoritesGetDataSuccess,

        );
      },

    );
  }

  Widget buildFavItem(Product? model,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.bottomLeft, children: [
            Image(
              image: NetworkImage(model!.image),
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
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, height: 1.3),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(fontSize: 12, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id);
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
