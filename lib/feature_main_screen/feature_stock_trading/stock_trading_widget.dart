import 'dart:developer';

import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_main_screen/feature_responses/reposne_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockTradingWidget extends StatefulWidget {
  const StockTradingWidget({Key? key, required this.stock}) : super(key: key);

  final ResponseStock? stock;

  @override
  State<StockTradingWidget> createState() => _StockTradingWidgetState();
}

class _StockTradingWidgetState extends State<StockTradingWidget> {
  int _counter = 1;

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Constants.colorLightPurple),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )));
  }

  Widget tradeButton({
    required BuildContext context,
    required String text,
    required String imagePath,
  }) {
    return TextButton(
      style: _buttonStyle(),
      onPressed: () => {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Image.asset(
                imagePath,
              ),
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _counterWidget(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 220),
      decoration: BoxDecoration(
        color: Constants.colorPurple,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customCounterTextBotton(
              text: '+',
              context: context,
              onPressed: () => {
                setState(() {
                  if (_counter < 100) {
                    _counter++;
                  }
                })
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Text('$_counter'),
            ),
            customCounterTextBotton(
              text: '-',
              context: context,
              onPressed: () => {
                setState(() {
                  if (_counter > 1) {
                    _counter--;
                  }
                })
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _stockTradeButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: tradeButton(
            context: context,
            text: 'Купить',
            imagePath: Constants.pathBuy,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: tradeButton(
            context: context,
            text: 'Продаить',
            imagePath: Constants.pathSell,
          ),
        ),
      ],
    );
  }

  Widget _stockTrade(BuildContext context) {
    log('_stockTrade | ${widget.stock!.lastUpdatedEpochTime}');
    final DateTime lastUpdated =
        DateTime.fromMillisecondsSinceEpoch(widget.stock!.lastUpdatedEpochTime);
    final String formattedDate = DateFormat('dd-MM-yyyy').format(lastUpdated);
    final String formattedTime = DateFormat('kk:mm:ss').format(lastUpdated);

    log('_stockTrade | $formattedDate $formattedTime');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Цена акции на $formattedDate $formattedTime',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '${widget.stock!.price.toStringAsFixed(2).replaceAll('.', ',')} у.е.',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        deltaText(
          context: context,
          stock: widget.stock!,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _counterWidget(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.stock == null) {
      return customCircularProgressIndicator();
    }

    return customCard(
      child: Row(
        children: [
          _stockTrade(context),
          _stockTradeButtons(context),
        ],
      ),
    );
  }
}
