import 'package:best_hack/config/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: white,
        colorScheme: ColorScheme(),
        scaffoldBackgroundColor: purple,
        fontFamily: 'AvenirNext');
  }
}
