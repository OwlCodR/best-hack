import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_main_screen/feature_responses/reposne_stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget deltaText({
  required BuildContext context,
  required ResponseStock stock,
}) {
  Color textColor = Constants.colorRed;
  String sign = '';

  if (stock.priceDelta.delta >= 0) {
    sign = '+';
    textColor = Constants.colorGreen;
  }

  return Text(
    '$sign${stock.priceDelta.delta.toStringAsFixed(2)} у.е. (${stock.priceDelta.percent.toStringAsFixed(2)}%)',
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
  );
}

Widget customCounterTextBotton({
  required BuildContext context,
  required Function() onPressed,
  required String text,
}) {
  return SizedBox(
    height: 40,
    width: 40,
    child: TextButton(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.bodySmall,
        backgroundColor: Constants.colorDarkPurple,
      ),
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    ),
  );
}

Widget customCircularProgressIndicator() {
  return SizedBox(
    height: 50,
    width: 50,
    child: CircularProgressIndicator(
      color: Constants.colorWhite,
    ),
  );
}

Widget customCard({required Widget child}) {
  return Card(
    margin: const EdgeInsets.all(30.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: child,
    ),
  );
}