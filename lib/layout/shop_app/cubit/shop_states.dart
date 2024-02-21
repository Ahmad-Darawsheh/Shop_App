import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/models/shop_app/profile_model.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/home_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ChangeBottomNavState extends ShopStates {}

class HomeLoadingDataState extends ShopStates {}

class HomeSuccessDataState extends ShopStates {
  late final HomeModel model;

  HomeSuccessDataState(this.model);
}

class HomeErrorDataState extends ShopStates {
  late final String error;

  HomeErrorDataState(this.error);
}

class CategoriesSuccessDataState extends ShopStates {
  CategoriesSuccessDataState();
}

class CategoriesErrorDataState extends ShopStates {
  late final String error;

  CategoriesErrorDataState(this.error);
}

class FavoritesSuccessDataState extends ShopStates {
  late final ChangeFavoritesModel model;

  FavoritesSuccessDataState(this.model);
}

class FavoritesChangeDataState extends ShopStates {}

class FavoritesErrorDataState extends ShopStates {
  late final String error;

  FavoritesErrorDataState(this.error);
}

class FavoritesGetDataSuccess extends ShopStates {}

class LoadingFavoritesGetDataSuccess extends ShopStates {}

class FavoritesGetDataError extends ShopStates {
  late final String error;

  FavoritesGetDataError(this.error);
}

class ProfileGetDataSuccess extends ShopStates {
  final LoginModel model;

  ProfileGetDataSuccess(this.model);
}

class ProfileLoadingData extends ShopStates {}

class ProfileGetDataError extends ShopStates {}

class LoadingUpdateProfileState extends ShopStates {}

class UpdateLoadingData extends ShopStates {}

class UpdateDataError extends ShopStates {}

class UpdateDataSuccess extends ShopStates {}