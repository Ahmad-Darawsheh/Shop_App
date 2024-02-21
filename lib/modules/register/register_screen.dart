import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/register/cubit_register.dart';
import 'package:shop_app/modules/register/states_register.dart';

import '../../layout/shop_app/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/cubit/cubit_login.dart';
import '../login/cubit/states_login.dart';
import '../login/shop_login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState ) {
            if (state.model.status) {
              CacheHelper.saveData(key: 'token', value: state.model.data.token)
                  .then((value) {
                navigateToAndFinish(context, const ShopLayout());
                token = state.model.data.token;
                print(token);
                ShopCubit.get(context).getProfile();
              });
              showToast(
                  message: state.model.message,
                  textColor: Colors.green,
                  state: toastStates.SUCCESS);
            } else {
              showToast(
                  message: state.model.message,
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
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          "Register to view our latest items",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                            TextEditingController: nameController,
                            TextInputType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                            label: "Name",
                            prefix: Icons.person),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          TextEditingController: emailController,
                          TextInputType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Enter your password please";
                            }
                            return null;
                          },
                          label: "Email",
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          TextEditingController: passwordController,
                          TextInputType: TextInputType.visiblePassword,
                          isPassword: RegisterCubit.get(context).isPassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Enter your password please";
                            }
                            return null;
                          },
                          label: "Password",
                          prefix: Icons.lock,
                          suffix: RegisterCubit.get(context).showAndHide,
                          iconFunction: () {
                            RegisterCubit.get(context).changePasswordVisbility();
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            TextEditingController: phoneController,
                            TextInputType: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your phone";
                              }
                              return null;
                            },
                            label: "Phone",
                            prefix: Icons.phone),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );


                              }
                            },
                            text: "Register",
                            isUpperCase: true,
                          ),

                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Have an account?"),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, ShopLoginScreen());
                                },
                                text: "login"),
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
