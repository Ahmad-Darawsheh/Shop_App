import 'package:shop_app/models/shop_app/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSucessState extends LoginStates {
  late final LoginModel model;

  LoginSucessState(this.model);
}

class LoginErrorState extends LoginStates {
  late final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisbility extends LoginStates {}




