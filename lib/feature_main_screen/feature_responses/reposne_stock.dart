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
    required this.name,
    required this.tag,
    required this.imageUrl,
    required this.state,
    required this.priceDelta,
  });

  double price;
  String name;
  String tag;
  String imageUrl;
  StockState state;
  _ResponsePriceDelta priceDelta;

  factory ResponseStock.fromJson(Map<String, dynamic> json) {
    // return ResponseStock(
    //   price: json['price'],
    //   name: json['name'],
    //   tag: json['tag'],
    //   imageUrl: json['image_url'],
    //   state: StockStateProvider.fromString(json['state']),
    //   priceDelta: _ResponsePriceDelta.fromjson(json['change']),
    // );
    return ResponseStock(
      price: json['price'],
      name: json['name'],
      tag: json['tag'],
      imageUrl: 'https://i.imgur.com/7Qc8TC8.png',
      state: StockStateProvider.fromString(json['state']),
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

class StockStateProvider {
  static fromString(String state) {
    switch (state) {
      case 'PRE':
        return StockState.PRE;
      case 'REGULAR':
        return StockState.REGULAR;
      case 'POST':
        return StockState.POST;
    }
  }
}

enum StockState { PRE, POST, REGULAR }