import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_states.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/favorites_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/models/shop_app/profile_model.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';

import '../../../modules/categories/categories_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int curindex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
     SettingsScreen(),
  ];

  void changeBottomNav(index) {
    curindex = index;
    emit(ChangeBottomNavState());
  }


  HomeModel? homeModel;
  Map<int, bool>? favorites = {};

  void getHomeData() {
    emit(HomeLoadingDataState());

    DioHelper.getData(path: HOME, token: token).then((value) {
      {
        homeModel = HomeModel.fromJson(value.data);

        homeModel?.data?.products.forEach((element) {
          // print(element.id);
          // print(element.inFavorites);
          favorites?.addAll({
            element.id: element.inFavorites,
          });
        });

        emit(HomeSuccessDataState(homeModel!));
      }
    }).catchError((onError) {
      print(onError.toString());

      emit(HomeErrorDataState(onError));
    });
  }

  CategoriesModel? categoryModel;

  void getCategories() {
    DioHelper.getData(path: GET_CATEGORIES).then((value) {
      {
        categoryModel = CategoriesModel.fromJson(value.data);

        emit(CategoriesSuccessDataState());

      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CategoriesErrorDataState(onError));

    });
  }

  ChangeFavoritesModel? favModel;

  void changeFavorites(int productId,) {
    favorites![productId] = !favorites![productId]!;
    emit(FavoritesChangeDataState());
    DioHelper.postData(
        path: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) =>
    {
      favModel = ChangeFavoritesModel.fromJson(value.data),
      print(value.data),

      if (!favModel!.status) {
        favorites![productId] = !favorites![productId]!
      }else{
        getFavorites()
      },

      emit(FavoritesSuccessDataState(favModel!)),
    })
        .catchError((onError) {
      print(onError.toString());
      favorites![productId] = !favorites![productId]!;
      emit(FavoritesErrorDataState(onError));
    });
  }

     FavoritesModel? getFavModel ;

  void getFavorites() {
    emit(LoadingFavoritesGetDataSuccess());
    DioHelper.getData(path: FAVORITES,token: token).then((value) {
      {
        getFavModel = FavoritesModel.fromJson(value.data);

        emit(FavoritesGetDataSuccess());

      }
    }).catchError((onError) {
      print(onError.toString());
      emit(FavoritesGetDataError(onError));

    });
  }

   LoginModel? userModel;

  void getProfile() {
    emit(ProfileLoadingData());

    DioHelper.getData(
      path: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      printFullText(userModel?.data?.name);

      emit(ProfileGetDataSuccess(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ProfileGetDataError());
    });
  }


  void updateProfile({required name,required email,required phone}) {
    emit(UpdateLoadingData());

    DioHelper.putData(
      path: UPDATE_PROFILE,
      token: token, data: {'name':name,'email':email,'phone':phone},
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      printFullText(userModel?.data.name);

      emit(UpdateDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateDataError());
    });
  }
}
