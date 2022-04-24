import 'dart:math';

import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_responses/response_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StocksListItemWidget extends StatefulWidget {
  const StocksListItemWidget({
    Key? key,
    required this.onItemTapped,
    required this.stock,
  }) : super(key: key);

  final ResponseStock stock;
  final Function(ResponseStock) onItemTapped;

  @override
  State<StocksListItemWidget> createState() => _StocksListItemWidgetState();
}

class _StocksListItemWidgetState extends State<StocksListItemWidget> {
  Widget _priceDelta(BuildContext context) {
    String arrowPath = AppConstants.paths.arrowDown;

    if (widget.stock.priceDelta.delta >= 0) {
      arrowPath = AppConstants.paths.arrowUp;
    }

    return Row(
      children: [
        deltaText(
          context: context,
          stock: widget.stock,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Image.asset(arrowPath),
        ),
      ],
    );
  }

  Widget _stockTitle(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.stock.sourceCurrency,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '${widget.stock.price.toStringAsFixed(4).replaceAll('.', ',')} ${widget.stock.targetCurrency}',
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    num time = 30 + Random().nextInt(60 - 30);
    Future.delayed(Duration(seconds: (time as int))).then((value) =>
        //debugPrint('Update $widget.stock.tag');
        ApiProvider.getStock(
          sourceCurrency: widget.stock.sourceCurrency,
          targetCurrency: widget.stock.targetCurrency,
        ).then((newStock) {
          widget.stock.price = newStock.price;
          widget.stock.priceDelta = newStock.priceDelta;
          widget.stock.lastUpdatedEpochTime =
              DateTime.now().millisecondsSinceEpoch;
        }));

    return ListTile(
      // Removes default padding from left and right
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Text(
            widget.stock.sourceCurrency,
            style: Theme.of(context).textTheme.headline4,
          ),
          const Spacer(),
          Text(
            widget.stock.price.toStringAsFixed(4).replaceAll('.', ','),
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
      onTap: () => widget.onItemTapped(widget.stock),
    );
  }
}
