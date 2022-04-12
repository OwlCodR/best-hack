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
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,

        // Define the default font family.
        fontFamily: 'AvenirNext',
      ),
      home: const MainScreen(title: 'Мой кошелек'),
    );
  }
}
