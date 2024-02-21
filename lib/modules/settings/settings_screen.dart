import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_states.dart';
import 'package:shop_app/modules/login/cubit/cubit_login.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children:
                [
                  if(state is UpdateLoadingData)
                   const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                    TextEditingController:  nameController,
                    TextInputType: TextInputType.name,
                    validator: (String? value) {
                      if (value?.isEmpty??false) {
                        return 'Name must not be empty';
                      }

                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                 const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                    TextEditingController: emailController,
                    TextInputType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value?.isEmpty??false) {
                        return 'Email must not be empty';
                      }

                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                    TextEditingController: phoneController,
                    TextInputType: TextInputType.phone,
                    validator: (String? value) {
                      if (value?.isEmpty??false) {
                        return 'Phone must not be empty';
                      }

                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: ()
                    {
                      if(formKey.currentState?.validate()??false)
                      {
                        ShopCubit.get(context).updateProfile(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
                    },
                    text: 'update',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: () {
                      signout(context);
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
