import 'dart:convert';
import 'dart:developer';

import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_main_screen/feature_responses/reposne_stock.dart';
import 'package:best_hack/feature_main_screen/feature_stocks_list/stocks_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    _futureResponseStocks = _getStocksList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(30.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: cardContent(context),
      ),
    );
  }

  Future<ResponseStocks> _getStocksList() async {
    final response = await http.get(
      Uri.parse('http://212.24.98.245:8080/127.0.0.1:8082/v1/stocks/current'),
    );

    if (response.statusCode == 200) {
      return ResponseStocks.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }

    // String mockedJson = """
    //     {"stocks":[{"change":{"percent":0.6094631,"plain":18.379883},"price":3034.13,"state":"POST","tag":"AMZN"},{"change":{"percent":-0.19757964,"plain":-1.9500122},"price":985,"state":"POST","tag":"TSLA"},{"change":{"percent":-1.8492606,"plain":-3.9600067},"price":210.18,"state":"POST","tag":"FB"},{"change":{"percent":-0.8736132,"plain":-22.429932},"price":2545.06,"state":"POST","tag":"GOOG"},{"change":{"percent":-0.86312157,"plain":-2.9700012},"price":341.13,"state":"POST","tag":"NFLX"},{"change":{"percent":-1.827594,"plain":-1.6600037},"price":89.17,"state":"POST","tag":"SONY"},{"change":{"percent":-0.3610105,"plain":-0.01999998},"price":5.52,"state":"POST","tag":"VUZI"},{"change":{"percent":1.9813528,"plain":0.17000008},"price":8.75,"state":"POST","tag":"GPRO"},{"change":{"percent":2.6134808,"plain":0.19000006},"price":7.46,"state":"POST","tag":"KOSS"},{"change":{"percent":-4.188095,"plain":-1.1399994},"price":26.08,"state":"POST","tag":"SONO"}]}
    //   """;
    // return ResponseStocks.fromJson(jsonDecode(mockedJson));
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
                  padding: const EdgeInsets.all(10),
                  itemCount: stocks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StocksListItemWidget(stock: stocks[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Constants.colorWhitePurple,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              log('Error: ${snapshot.error}');
              return Text(
                'Failed to load data.',
                style: Theme.of(context).textTheme.labelMedium,
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
