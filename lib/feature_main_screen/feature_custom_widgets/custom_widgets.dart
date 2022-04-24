import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_responses/response_stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget deltaText({
  required BuildContext context,
  required ResponseStock stock,
}) {
  Color textColor = AppConstants.colors.red;
  String sign = '';

  if (stock.priceDelta.delta >= 0) {
    sign = '+';
    textColor = AppConstants.colors.green;
  }

  return Text(
    '$sign${stock.priceDelta.delta.toStringAsFixed(2)} у.е. (${stock.priceDelta.percent.toStringAsFixed(2)}%)',
    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: textColor),
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
        textStyle: Theme.of(context).textTheme.headline5,
        backgroundColor: AppConstants.colors.darkPurple,
      ),
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
      ),
    ),
  );
}

Widget customCircularProgressIndicator() {
  return SizedBox(
    height: 50,
    width: 50,
    child: CircularProgressIndicator(
      color: AppConstants.colors.blue,
    ),
  );
}

Widget customCard({required Widget child}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: child,
    ),
  );
}
