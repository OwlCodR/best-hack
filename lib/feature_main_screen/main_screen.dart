import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_main_screen/feature_stocks_list/stocks_list_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const StocksListWidget(),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 110,
      backgroundColor: Constants.colorPurple,
      title: titleWidget(context),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: TextButton(
              onPressed: () => {},
              child: Text(
                'Войти',
                style: TextStyle(
                  color: Constants.colorWhite,
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
    return PreferredSize(
      preferredSize: Size.zero,
      child: Padding(
        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
        child: Divider(
          thickness: 0.5,
          color: Constants.colorWhite,
        ),
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset(
            Constants.pathLogoPng,
            height: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Center(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.displayLarge,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Делаем ваши ',
                    style: TextStyle(
                      color: Constants.colorWhite,
                    ),
                  ),
                  TextSpan(
                    text: 'торги удобными',
                    style: TextStyle(
                      color: Constants.colorGreen,
                    ),
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
