import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/config/themes/light_theme.dart';
import 'package:best_hack/feature_main_screen/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stonks Inc.',
      initialRoute: Constants.routeMainScreen,
      routes: {
        Constants.routeMainScreen: (context) => const MainScreen(),
      },
      theme: CustomTheme.getLightTheme(),
    );
  }
}
