import 'dart:developer';

import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_main_screen/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_main_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:best_hack/feature_main_screen/feature_responses/reposne_stock.dart';
import 'package:best_hack/feature_main_screen/feature_stocks_list/stocks_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StocksListWidget extends StatefulWidget {
  const StocksListWidget({Key? key}) : super(key: key);

  @override
  State<StocksListWidget> createState() => _StocksListWidgetState();
}

class _StocksListWidgetState extends State<StocksListWidget> {
  Future<ResponseStocks>? _futureResponseStocks;

  @override
  void initState() {
    super.initState();
    _futureResponseStocks = ApiProvider.getStocks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 650),
      child: customCard(
        child: cardContent(context),
      ),
    );
  }

  Widget cardContent(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Акции',
              style: Theme.of(context).textTheme.displayLarge,
            ),
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
                    return StocksListItemWidget(stock: stocks[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Constants.colorVeryLightPurple,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              log('Error: ${snapshot.error}');
              return Text(
                'Failed to load data.',
                style: Theme.of(context).textTheme.labelLarge,
              );
            } else {
              return CircularProgressIndicator(
                color: Constants.colorWhite,
              );
            }
          },
        )
      ],
    );
  }
}
