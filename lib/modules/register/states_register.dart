import 'package:shop_app/models/shop_app/login_model.dart';

import '../../models/shop_app/register_model.dart';

abstract class RegisterStates {}


class RegisterInitialState extends RegisterStates {}

class RegisterChangePasswordVisbility extends RegisterStates {}


class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  late final RegisterModel model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterStates {
  // late final String error;
  //
  // RegisterErrorState(this.error);
}

