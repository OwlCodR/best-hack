import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_main_screen/feature_responses/reposne_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockTradingWidget extends StatelessWidget {
  const StockTradingWidget({Key? key, required this.stock}) : super(key: key);

  final ResponseStock? stock;

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
    final DateTime now = DateTime.now();
    final DateFormat date = DateFormat('dd-MM-yyyy');
    final DateFormat time = DateFormat('HH:MM');
    final String formattedDate = date.format(now);
    final String formattedTime = time.format(now);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Цена акции на $formattedDate $formattedTime',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '${stock!.price.toStringAsFixed(2).replaceAll('.', ',')} \$\$',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        deltaText(
          context: context,
          stock: stock!,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (stock == null) {
      return CircularProgressIndicator(
        color: Constants.colorWhite,
      );
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
