// ignore_for_file: constant_identifier_names

class ResponseStocks {
  ResponseStocks({
    required this.stocks,
  });

  List<ResponseStock> stocks;

  factory ResponseStocks.fromJson(Map<String, dynamic> json) {
    List<ResponseStock> _stocks = [];
    for (var stock in json['stocks']) {
      _stocks.add(ResponseStock.fromJson(stock));
    }
    return ResponseStocks(stocks: _stocks);
  }
}

class ResponseStock {
  ResponseStock({
    required this.price,
    required this.sellPrice,
    required this.buyPrice,
    required this.priceDelta,
    required this.sourceCurrency,
    required this.targetCurrency,
    required this.lastUpdatedEpochTime,
  });

  double price;
  double sellPrice;
  double buyPrice;

  String sourceCurrency;
  String targetCurrency;
  int lastUpdatedEpochTime; // ms
  _ResponsePriceDelta priceDelta;

  factory ResponseStock.fromJson(Map<String, dynamic> json) {
    return ResponseStock(
      price: json['price'],
      sellPrice: json['sellPrice'],
      buyPrice: json['buyPrice'],
      sourceCurrency: json['sourceCurrency'],
      targetCurrency: json['targetCurrency'],
      lastUpdatedEpochTime: DateTime.now().millisecondsSinceEpoch,
      priceDelta: _ResponsePriceDelta.fromjson(json['change']),
    );
  }
}

class _ResponsePriceDelta {
  _ResponsePriceDelta({required this.delta, required this.percent});

  double delta;
  double percent;

  factory _ResponsePriceDelta.fromjson(Map<String, dynamic> json) {
    return _ResponsePriceDelta(
      delta: json['plain'],
      percent: json['percent'],
    );
  }
}
