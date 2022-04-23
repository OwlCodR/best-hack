import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_main_screen/feature_stocks_list/stocks_list_item_widget.dart';
import 'package:best_hack/feature_responses/reposne_stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StocksListWidget extends StatefulWidget {
  const StocksListWidget({
    Key? key,
    required this.onItemTapped,
    required this.currency,
  }) : super(key: key);

  final Function(ResponseStock) onItemTapped;
  final String currency;

  @override
  State<StocksListWidget> createState() => _StocksListWidgetState();
}

class _StocksListWidgetState extends State<StocksListWidget> {
  Future<ResponseStocks>? _futureResponseStocks;

  @override
  void initState() {
    super.initState();
    _futureResponseStocks = ApiProvider.getStocks(widget.currency);
  }

  @override
  Widget build(BuildContext context) {
    return customCard(
      child: cardContent(context),
    );
  }

  Widget cardContent(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Курсы валют',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        FutureBuilder(
          future: _futureResponseStocks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var stocks = (snapshot.data as ResponseStocks).stocks;
              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: stocks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StocksListItemWidget(
                      onItemTapped: (stock) => widget.onItemTapped(stock),
                      stock: stocks[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: AppConstants.colors.veryLightPurple,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              debugPrint('cardContent() | Error: ${snapshot.error}');
              return Expanded(
                child: Center(
                  child: Text(
                    'Failed to load data.',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              );
            } else {
              return customCircularProgressIndicator();
            }
          },
        )
      ],
    );
  }
}
