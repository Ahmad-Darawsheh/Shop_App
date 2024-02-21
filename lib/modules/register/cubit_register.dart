import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/login/cubit/states_login.dart';
import 'package:shop_app/modules/register/states_register.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../models/shop_app/register_model.dart';
import '../login/cubit/cubit_login.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  late RegisterModel regModel;
  IconData showAndHide = Icons.visibility;
  bool isPassword = true;

  static RegisterCubit get(context) => BlocProvider.of(context);

  void changePasswordVisbility() {
    isPassword = !isPassword;
    isPassword
        ? showAndHide = Icons.visibility
        : showAndHide = Icons.visibility_off;
    emit(RegisterChangePasswordVisbility());
  }

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {

    emit(RegisterLoadingState());

    DioHelper.postData(path: REGISTER, data: {'name':name,'email': email, 'password': password,'phone':phone}).then((value) {

      regModel=RegisterModel.fromJson(value.data);
      print(regModel.status);
      emit(RegisterSuccessState(regModel));
    }).catchError((onError){
      print(onError.toString());
      emit(RegisterErrorState());
    });
  }
}
