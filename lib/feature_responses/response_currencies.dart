class ResponseCurrencies {
  ResponseCurrencies({
    required this.currencies,
  });

  List<ResponseCurrency> currencies;

  factory ResponseCurrencies.fromJson(Map<String, dynamic> json) {
    List<ResponseCurrency> currencies = [];
    for (var currency in json['currencies']) {
      currencies.add(ResponseCurrency.fromJson(currency));
    }

    return ResponseCurrencies(
      currencies: currencies,
    );
  }
}

class ResponseCurrency {
  ResponseCurrency({
    required this.tag,
    required this.name,
  });
  String tag;
  String name;

  factory ResponseCurrency.fromJson(Map<String, dynamic> json) {
    return ResponseCurrency(
      tag: json['tag'],
      name: json['name'],
    );
  }
}
