import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_main_screen/feature_chart/chart_widget.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_main_screen/feature_stocks_list/stocks_list_widget.dart';
import 'package:best_hack/feature_responses/response_currencies.dart';
import 'package:best_hack/feature_responses/response_stock.dart';
import 'package:flutter/material.dart';

import 'feature_stock_trade/stock_trade_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ResponseStock? _currentStock;
  // ResponseNews? _currentNews;
  ResponseCurrency _currentCurrency =
      ResponseCurrency(tag: 'RUB', name: 'Russian Ruble');
  ResponseCurrencies? _currencies;
  late double _currentBalance;

  @override
  void initState() {
    super.initState();

    _currentBalance = 0;
    _loadCurrencies();

    if (_currentStock == null) {
      _setDefaultStock();
    }
  }

  void _loadCurrencies() {
    debugPrint('_loadCurrencies');
    ApiProvider.getCurrencies().then((currencies) {
      setState(() {
        _currentCurrency = currencies.currencies[0];
        _currencies = currencies;
      });
    });
  }

  void _setDefaultStock() {
    ApiProvider.getStocks(_currentCurrency.tag).then(
      (response) {
        if (response.stocks.isNotEmpty) {
          debugPrint(
              'main_screen initState() | ApiProvider.getStocks().then()');
          _currentStock = response.stocks[0];
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: StocksListWidget(
                currentCurrency: _currentCurrency,
                onItemTapped: (stock) => {
                  setState(() {
                    _currentStock = stock;
                    debugPrint('SetState() $_currentStock');
                  }),
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: _currentStock != null
                        ? StockTradeWidget(
                            targetCurrency: _currentCurrency,
                            currentStock: _currentStock!,
                          )
                        : Center(child: customCircularProgressIndicator()),
                  ),
                  Expanded(
                    flex: 4,
                    child: ChartWidget(
                      animate: false,
                      stock: _currentStock,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text('Text'),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 100,
      backgroundColor: AppConstants.colors.lightBlue,
      title: Row(
        children: [
          titleWidget(context),
          const SizedBox(
            width: 40,
          ),
          _chooseCurrency(),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: TextButton(
              onPressed: () => {},
              child: Row(
                children: [
                  Text(
                    'Мой профиль',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: Image.asset(AppConstants.paths.avatar),
                  ),
                  const SizedBox(
                    width: 32,
                    height: 32,
                    child: Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                ],
              )),
        ),
      ],
      bottom: dividerWidget(),
    );
  }

  Widget _chooseCurrency() {
    if (_currencies == null) {
      return customCircularProgressIndicator();
    }
    debugPrint('${_currencies!.currencies}');

    return DropdownButton<ResponseCurrency>(
      items: _currencies!.currencies.map((ResponseCurrency currency) {
        return DropdownMenuItem<ResponseCurrency>(
          value: currency,
          child: Text(currency.tag),
        );
      }).toList(),
      value: _currentCurrency,
      style: TextStyle(color: AppConstants.colors.blue),
      onChanged: (currency) {
        if (currency != null) {
          setState(() {
            debugPrint('Clicked!');
            _currentCurrency = currency;
          });
        }
      },
    );
  }

  PreferredSizeWidget dividerWidget() {
    return PreferredSize(
      preferredSize: Size.zero,
      child: Divider(
        thickness: 1,
        color: AppConstants.colors.gray,
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset(
            AppConstants.paths.logoPng,
            height: 40,
          ),
        ),
      ],
    );
  }
}
