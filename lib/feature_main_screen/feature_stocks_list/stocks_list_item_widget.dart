import 'dart:developer';

import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_main_screen/feature_responses/reposne_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StocksListItemWidget extends StatelessWidget {
  const StocksListItemWidget({Key? key, required this.stock}) : super(key: key);

  final ResponseStock stock;

  Widget _priceDelta(BuildContext context) {
    String arrowPath = Constants.pathArrowDown;
    Color textColor = Constants.colorRed;
    String sign = '';

    if (stock.priceDelta.delta >= 0) {
      sign = '+';
      textColor = Constants.colorGreen;
      arrowPath = Constants.pathArrowUp;
    }

    return Row(
      children: [
        Text(
          '$sign${stock.priceDelta.delta.toStringAsFixed(2)} \$\$ (${stock.priceDelta.percent.toStringAsFixed(2)}%)',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(arrowPath),
        ),
      ],
    );
  }

  Widget _stockTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stock.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          '1 шт ${stock.price.toString().replaceAll('.', ',')} \$\$',
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Removes default padding from left and right
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(
          stock.imageUrl,
        ),
      ),
      title: Row(
        children: [
          _stockTitle(context),
          const Spacer(),
          _priceDelta(context),
        ],
      ),
      onTap: () => log('Tapped'),
    );
  }
}