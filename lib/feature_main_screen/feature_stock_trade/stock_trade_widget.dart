import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_responses/response_currencies.dart';
import 'package:best_hack/feature_responses/response_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StockTradeWidget extends StatefulWidget {
  const StockTradeWidget({
    Key? key,
    required this.currentStock,
    required this.targetCurrency,
  }) : super(key: key);

  final ResponseStock currentStock;
  final ResponseCurrency targetCurrency;

  @override
  State<StockTradeWidget> createState() => _StockTradeWidgetState();
}

class _StockTradeWidgetState extends State<StockTradeWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    debugPrint('_StockTradeWidgetState: ${widget.currentStock}');
    if (widget.currentStock != null) {
      debugPrint('_StockTradeWidgetState: ${widget.currentStock.sellPrice}');
      debugPrint('_StockTradeWidgetState: ${widget.currentStock.buyPrice}');
    }

    if (widget.currentStock.sellPrice == 0) {
      ApiProvider.getStock(
        sourceCurrency: widget.currentStock.sourceCurrency,
        targetCurrency: widget.targetCurrency.tag,
      ).then((stock) => {
            setState(() {
              widget.currentStock.buyPrice = stock.buyPrice;
              widget.currentStock.sellPrice = stock.sellPrice;
            }),
          });
    }

    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: priceWidget(
                title: 'Продажа по цене',
                price: widget.currentStock.sellPrice
                    .toStringAsFixed(4)
                    .replaceAll('.', ','),
                bottom: 'Продаю',
                onChanged: (changedCount) => {},
              ),
            ),
          ),
          Expanded(flex: 1, child: Center(child: changingWidget())),
          Expanded(
            flex: 3,
            child: Center(
              child: priceWidget(
                title: 'Покупка по цене',
                price: widget.currentStock.buyPrice
                    .toStringAsFixed(4)
                    .replaceAll('.', ','),
                bottom: 'Покупаю',
                onChanged: (changedCount) => {},
              ),
            ),
          ),
          Expanded(flex: 4, child: Center(child: buyingWidget())),
        ],
      ),
    );
  }

  Widget priceWidget({
    required String title,
    required String bottom,
    required String price,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: AppConstants.colors.gray,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              color: AppConstants.colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            bottom,
            style: TextStyle(
              fontSize: 12,
              color: AppConstants.colors.gray,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppConstants.colors.lightGray,
                    width: 2,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              inputFormatters: [LengthLimitingTextInputFormatter(8)],
              keyboardType: TextInputType.number,
              maxLines: 1,
              onChanged: (changedCount) => onChanged(changedCount),
              style: TextStyle(
                color: AppConstants.colors.black,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget changingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.currentStock.sourceCurrency,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 21,
              color: AppConstants.colors.blue,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(AppConstants.paths.exchange)),
      ],
    );
  }

  Widget buyingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Купить валюту',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: AppConstants.colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              checkColor: AppConstants.colors.white,
              fillColor: MaterialStateProperty.all(AppConstants.colors.blue),
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value!;
                });
              },
            ),
            Text(
              'Уведомлять при\nизменении',
              style: TextStyle(
                fontSize: 12,
                color: AppConstants.colors.gray,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
