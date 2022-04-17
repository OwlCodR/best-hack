import 'dart:convert';
import 'dart:developer';

import 'package:best_hack/feature_main_screen/feature_responses/reposne_stock.dart';
import 'package:best_hack/feature_main_screen/feature_responses/response_chart.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static const String _protocol = 'http://';
  static const String _apiServer = '212.24.98.245:8080/127.0.0.1:8082/';

  static Uri _uri(String url) {
    return Uri.parse('$_protocol$_apiServer$url');
  }

  static Future<ResponseStocks> getStocks() async {
    log('getStocks() | Loading...');
    final response = await http.get(_uri(('v1/stocks/current')));
    log('${jsonDecode(response.body)}');
    if (response.statusCode == 200) {
      log('getStocks() | response.statusCode = ${response.statusCode}');
      return ResponseStocks.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }

    // String mockedJson = """
    //     {"stocks":[{"change":{"percent":0.6094631,"plain":18.379883},"price":3034.13,"state":"POST","tag":"AMZN"},{"change":{"percent":-0.19757964,"plain":-1.9500122},"price":985,"state":"POST","tag":"TSLA"},{"change":{"percent":-1.8492606,"plain":-3.9600067},"price":210.18,"state":"POST","tag":"FB"},{"change":{"percent":-0.8736132,"plain":-22.429932},"price":2545.06,"state":"POST","tag":"GOOG"},{"change":{"percent":-0.86312157,"plain":-2.9700012},"price":341.13,"state":"POST","tag":"NFLX"},{"change":{"percent":-1.827594,"plain":-1.6600037},"price":89.17,"state":"POST","tag":"SONY"},{"change":{"percent":-0.3610105,"plain":-0.01999998},"price":5.52,"state":"POST","tag":"VUZI"},{"change":{"percent":1.9813528,"plain":0.17000008},"price":8.75,"state":"POST","tag":"GPRO"},{"change":{"percent":2.6134808,"plain":0.19000006},"price":7.46,"state":"POST","tag":"KOSS"},{"change":{"percent":-4.188095,"plain":-1.1399994},"price":26.08,"state":"POST","tag":"SONO"}]}
    //   """;
    // return ResponseStocks.fromJson(jsonDecode(mockedJson));
  }

  static Future<ResponseStock> getStock(String tag) async {
    log('getChart() | Loading...');
    final response = await http.get(
      _uri(('v1/stocks/$tag')),
    );
    log('Body: ${response.body}');
    if (response.statusCode == 200) {
      log('getChart() | response.statusCode = ${response.statusCode}');
      return ResponseStock.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }

  static Future<ResponseChart> getChart(String tag) async {
    log('getChart() | Loading...');
    final response = await http.post(
      _uri(('v1/stocks/$tag/graph')),
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'period': 7,
        'pointsCount': 7,
      }),
    );
    log('Body: ${response.body}');
    if (response.statusCode == 200) {
      log('getChart() | response.statusCode = ${response.statusCode}');
      return ResponseChart.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }
}
