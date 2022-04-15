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
    '$sign${stock.priceDelta.delta.toStringAsFixed(2)} \$\$ (${stock.priceDelta.percent.toStringAsFixed(2)}%)',
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
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
