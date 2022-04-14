import 'package:best_hack/config/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      backgroundColor: Constants.colorPurple,
      primaryColor: Constants.colorPurple,
      primaryColorLight: Constants.colorLightPurple,
      primaryColorDark: Constants.colorDarkPurple,
      // disabledColor: const Color(0x80272727),
      // shadowColor: const Color(0x80000000),
      cardColor: Constants.colorDarkPurple,
      dividerColor: Constants.colorWhite,
      errorColor: Constants.colorRed,
      scaffoldBackgroundColor: Constants.colorPurple,
      fontFamily: 'AvenirNext',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: Constants.colorWhite,
          fontFamily: 'AvenirNext',
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: Constants.colorWhite,
          fontFamily: 'AvenirNext',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: Constants.colorWhite,
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: Constants.colorGray,
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        labelMedium: TextStyle(
          color: Constants.colorRed,
          fontFamily: 'AvenirNext',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
