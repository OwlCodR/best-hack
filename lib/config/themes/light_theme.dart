import 'package:best_hack/config/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: colorWhite,
        primaryColorLight: colorLightPurple,
        primaryColorDark: colorDarkPurple,
        scaffoldBackgroundColor: colorPurple,
        fontFamily: 'AvenirNext');
  }
}
