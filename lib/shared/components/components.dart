import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../models/shop_app/login_model.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateToAndFinish  (context, widget) =>
    Navigator.pushAndRemoveUntil(context
        ,MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget defaultTextFormField({
  required TextEditingController,
  required TextInputType,
  required FormFieldValidator<String>? validator,
  required String label,
  required IconData prefix,
  Function()? onTap,
  IconData? suffix,
  bool isPassword = false,
  Function? iconFunction,
  Function(String)? onChange,
  Function(String)? onSubmit,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: TextEditingController,
      keyboardType: TextInputType,
      onTap: onTap ?? () {},
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        enabled: isClickable,
        suffixIcon: suffix != null
            ? IconButton(
          icon: Icon(suffix),
          onPressed: () {
            iconFunction!();
          },
        )
            : null,
      ),
      obscureText: isPassword,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );


Widget defaultTextButton({
  required Function()? function,
  required String text,
}) =>TextButton(
    onPressed: function,
    child:  Text(
      text.toUpperCase(),
    )
);

void showToast( {
  required String message,
  required Color textColor,
  required toastStates state,
})=>Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor:textColor,
    backgroundColor: chooseToastColor(state),
    fontSize: 16
);

enum toastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(toastStates state){
  Color color;
  switch(state){
    case toastStates.SUCCESS:
      color= Colors.green;
    break;

    case toastStates.ERROR:
      color=Colors.red;
    break;

    case toastStates.WARNING:
      color=Colors.amber;
    break;

  }
  return color;
}
