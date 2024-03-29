import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_states.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoryModel!.data!.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).categoryModel!.data!.data.length);
      },

    );
  }


  Widget buildCatItem(DataModel model) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children:  [
            Image(
              image: NetworkImage(
                  model.image!),
              width: 80,
              height: 80,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const  Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );


}
