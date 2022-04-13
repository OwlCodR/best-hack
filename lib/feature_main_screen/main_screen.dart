import 'package:best_hack/config/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: ,
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 130,
      backgroundColor: colorPurple,
      title: titleWidget(),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: TextButton(
              onPressed: () => {},
              child: const Text(
                'Войти',
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ],
      bottom: dividerWidget(),
    );
  }

  PreferredSizeWidget dividerWidget() {
    return const PreferredSize(
      preferredSize: Size.zero,
      child: Divider(
        thickness: 0.5,
        color: colorWhite,
      ),
    );
  }

  Widget titleWidget() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset(
            'assets/images/logo.png',
            height: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Center(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Делаем ваши ',
                    style:
                        TextStyle(color: colorWhite, fontFamily: 'AvenirNext'),
                  ),
                  TextSpan(
                    text: 'торги удобными',
                    style:
                        TextStyle(color: colorGreen, fontFamily: 'AvenirNext'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
