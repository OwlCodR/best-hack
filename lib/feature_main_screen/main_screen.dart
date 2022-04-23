import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_main_screen/feature_chart/chart_widget.dart';
import 'package:best_hack/feature_main_screen/feature_stock_info/stock_info_widget.dart';
import 'package:best_hack/feature_main_screen/feature_stock_trading/stock_trading_widget.dart';
import 'package:best_hack/feature_main_screen/feature_stocks_list/stocks_list_widget.dart';
import 'package:best_hack/feature_responses/reposne_stock.dart';
import 'package:best_hack/feature_responses/response_currencies.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ResponseStock? _currentStock;
  // ResponseNews? _currentNews;
  late String _currentCurrency;
  late ResponseCurrencies _currencies;
  late double _currentBalance;

  @override
  void initState() {
    super.initState();

    _currentBalance = 0;
    _currentCurrency = 'RUB';
    _loadCurrencies();

    if (_currentStock == null) {
      _setDefaultStock();
    }
  }

  void _loadCurrencies() {
    ApiProvider.getCurrencies().then((currencies) => setState(() {
          _currentCurrency = currencies.currencies[0].tag;
          _currencies = currencies;
        }));
  }

  void _setDefaultStock() {
    ApiProvider.getStocks(_currentCurrency).then(
      (response) {
        if (response.stocks.isNotEmpty) {
          setState(() {
            debugPrint(
                'main_screen initState() | ApiProvider.getStocks().then()');
            _currentStock = response.stocks[0];
          });
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
                currency: _currentCurrency,
                onItemTapped: (stock) => setState(() {
                  _currentStock = stock;
                }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      StockInfoWidget(
                        stock: _currentStock,
                      ),
                      StockTradingWidget(
                        stock: _currentStock,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: SizedBox(
                      width: 1000,
                      height: 500,
                      child: ChartWidget(
                        animate: false,
                        stock: _currentStock,
                      ),
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
      title: titleWidget(context),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: TextButton(
              onPressed: () => {},
              child: Row(
                children: [
                  Text(
                    'Войти',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppConstants.paths.login,
                      scale: 1.3,
                    ),
                  ),
                ],
              )),
        ),
      ],
      bottom: dividerWidget(),
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
