import 'dart:math';

import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_main_screen/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_main_screen/feature_responses/reposne_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StocksListItemWidget extends StatefulWidget {
  const StocksListItemWidget(
      {Key? key, required this.onItemTapped, required this.stock})
      : super(key: key);

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.stock.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '1 шт ${widget.stock.price.toStringAsFixed(2).replaceAll('.', ',')} у.е.',
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    num time = 8 + Random().nextInt(16 - 8);
    Future.delayed(Duration(seconds: (time as int)))
        .then((value) => setState(() async {
              // log('Update $widget.stock.tag');
              ResponseStock newStock =
                  await ApiProvider.getStock(widget.stock.tag);
              widget.stock.price = newStock.price;
              widget.stock.priceDelta = newStock.priceDelta;
              widget.stock.lastUpdatedEpochTime =
                  DateTime.now().millisecondsSinceEpoch;
            }));

    return ListTile(
      // Removes default padding from left and right
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(
          widget.stock.imageUrl,
        ),
      ),
      title: Row(
        children: [
          _stockTitle(context),
          const Spacer(),
          _priceDelta(context),
        ],
      ),
      onTap: () => widget.onItemTapped(widget.stock),
    );
  }
}
