import 'package:best_hack/config/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      backgroundColor: AppConstants.colors.lightBlue,
      primaryColor: AppConstants.colors.blue,
      primaryColorLight: AppConstants.colors.lightBlue,
      primaryColorDark: AppConstants.colors.blue,
      // disabledColor: const Color(0x80272727),
      // shadowColor: const Color(0x80000000),
      cardColor: AppConstants.colors.white,
      dividerColor: AppConstants.colors.gray,
      errorColor: AppConstants.colors.red,
      scaffoldBackgroundColor: AppConstants.colors.lightBlue,
      fontFamily: 'SegoeUI',
      textTheme: TextTheme(
        headline1: TextStyle(
          color: AppConstants.colors.blue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          color: AppConstants.colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headline3: TextStyle(
          color: AppConstants.colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color: AppConstants.colors.white,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        headline5: TextStyle(
          color: AppConstants.colors.gray,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        subtitle1: TextStyle(
          color: AppConstants.colors.red,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        subtitle2: TextStyle(
          color: AppConstants.colors.gray,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
