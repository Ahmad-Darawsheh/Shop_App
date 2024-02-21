import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/login/cubit/states_login.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  late LoginModel model;
  IconData showAndHide=Icons.visibility;
  bool isPassword=true;

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(path: LOGIN, data: {'email': email, 'password': password}).then((value) {

      model=LoginModel.fromJson(value.data);
      print(model.status);
      emit(LoginSucessState(model));
    }).catchError((onError){
      print(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }


  void changePasswordVisbility(){
    isPassword=!isPassword;
    isPassword?showAndHide= Icons.visibility:showAndHide= Icons.visibility_off;
    emit(ChangePasswordVisbility());

  }


}
