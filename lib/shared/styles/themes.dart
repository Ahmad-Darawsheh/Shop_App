

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darkTheme= ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: defaultColor
  ),
  fontFamily: 'Janna',
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),
    iconTheme: const IconThemeData(
        color: Colors.white
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      statusBarIconBrightness: Brightness.light,
    ),
    color: HexColor('333739'),
    elevation: 30,
    actionsIconTheme: IconThemeData(color: Colors.white),

  ),

  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 30,
      backgroundColor: HexColor('333739'),
      unselectedItemColor: Colors.white
  ),

  textTheme: const TextTheme(bodyMedium:TextStyle(
      fontSize: 18,fontWeight: FontWeight.w600,
      color: Colors.white,fontFamily: 'Janna',
  ),headlineMedium: TextStyle(
    color: Colors.white,fontFamily: 'Janna',
  ) ),

);

ThemeData lightTheme=ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: defaultColor
  ),
  appBarTheme:const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black,

      ),

      titleSpacing: 20,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.red,
        statusBarIconBrightness: Brightness.light,
      ),
      color: Colors.white,
      elevation: 0,
      actionsIconTheme: IconThemeData(color: Colors.black)
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 30
  ),
  textTheme: const TextTheme(bodyMedium:TextStyle(
      fontSize: 18,fontWeight: FontWeight.w600,
      color: Colors.black,fontFamily: 'Janna',
  ),headlineMedium: TextStyle(
      color: Colors.black,fontFamily: 'Janna',
  ) ),
);