import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit_login.dart';
import 'package:shop_app/modules/login/cubit/states_login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../shared/components/constants.dart';
import '../register/register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSucessState) {
            if (state.model.status) {
              print(state.model.message);
              print(state.model.data.token);

              CacheHelper.saveData(key: 'token', value: state.model.data.token)
                  .then((value) {
                    navigateToAndFinish(context,const ShopLayout());
                    token=state.model.data.token;
                  }
              );

              showToast(
                  message: state.model.message!,
                  textColor: Colors.green,
                  state: toastStates.SUCCESS);
            } else {
              showToast(
                  message: state.model.message!,
                  textColor: Colors.red,
                  state: toastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          "login to view our latest items",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                            TextEditingController: emailController,
                            TextInputType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                            label: "Email Address",
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          TextEditingController: passwordController,
                          TextInputType: TextInputType.visiblePassword,
                          isPassword: LoginCubit
                              .get(context)
                              .isPassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Password is too short";
                            }
                            return null;
                          },
                          label: "Password",
                          prefix: Icons.password_outlined,
                          suffix: LoginCubit
                              .get(context)
                              .showAndHide,
                          iconFunction: () {
                            LoginCubit.get(context).changePasswordVisbility();
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          builder: (context) =>
                              defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: "Login",
                                isUpperCase: true,
                              ),
                          condition: state is! LoginLoadingState,
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: "register"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
