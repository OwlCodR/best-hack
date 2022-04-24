import 'dart:convert';

import 'package:best_hack/feature_requests/request_login.dart';
import 'package:best_hack/feature_requests/request_register.dart';
import 'package:best_hack/feature_responses/response_chart.dart';
import 'package:best_hack/feature_responses/response_currencies.dart';
import 'package:best_hack/feature_responses/response_login.dart';
import 'package:best_hack/feature_responses/response_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static const String _protocol = 'http://';
  static const String _apiServer = '212.24.98.245:8080/127.0.0.1:8082/';

  static Uri _uri(String url) {
    return Uri.parse('$_protocol$_apiServer$url');
  }

  static Future<ResponseStocks> getStocks(String tag) async {
    debugPrint('getStocks($tag) | Loading...');
    final response = await http.get(_uri('v1/stocks/$tag/current'));
    debugPrint('getStocks() | Response body: ${jsonDecode(response.body)}');
    if (response.statusCode == 200) {
      debugPrint('getStocks() | response.statusCode = ${response.statusCode}');
      return ResponseStocks.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }

  static Future<ResponseStock> getStock({
    required String sourceCurrency,
    required String targetCurrency,
  }) async {
    debugPrint('getStock($sourceCurrency, $targetCurrency) | Loading...');
    final response = await http.get(
      _uri('v1/stocks/$targetCurrency/$sourceCurrency'),
    );
    debugPrint('getStock() | Body: ${response.body}');
    if (response.statusCode == 200) {
      debugPrint('getStock() | Loaded');
      return ResponseStock.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }

  static Future<ResponseCurrencies> getCurrencies() async {
    debugPrint('getCurrencies() | Loading...');
    final response = await http.get(
      _uri('v1/stocks/currencies'),
    );
    debugPrint('getCurrencies() | Body: ${response.body}');
    if (response.statusCode == 200) {
      debugPrint('getCurrencies() | Loaded');
      return ResponseCurrencies.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }

  static Future<void> signUp(RequestRegister request) async {
    debugPrint('signUp() | Signing up...');
    final response = await http.post(
      _uri('v1/user/register'),
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );
    debugPrint('signUp() | Body: ${jsonEncode(request.toJson())}');
    debugPrint('signUp() | Body: ${response.body}');
    if (response.statusCode == 200) {
      debugPrint('signUp() | response.statusCode = ${response.statusCode}');
    } else {
      throw Exception('Failed to load data.');
    }
  }

  static Future<ResponseLogin> signIn(RequestLogin request) async {
    debugPrint('signIn() | Signing up...');
    final response = await http.post(
      _uri('v1/auth/login'),
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    debugPrint(
        'signIn() | Sending body: ${jsonEncode(request.toJson()).toString()}');
    debugPrint('signIn() | Response body: ${response.body}');

    if (response.statusCode == 200) {
      debugPrint('signIn() | response.statusCode = ${response.statusCode}');
      return ResponseLogin.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }

  static Future<ResponseChart> getChart({
    required String sourceCurrency,
    required String targetCurrency,
  }) async {
    debugPrint('getChart() | Loading...');
    final response = await http.post(
      _uri(('v1/stocks/$targetCurrency/$sourceCurrency/graph')),
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'period': 30,
        'pointsCount': 10,
      }),
    );
    debugPrint('getChart() | Reposnse body: ${response.body}');
    if (response.statusCode == 200) {
      debugPrint('getChart() | response.statusCode = ${response.statusCode}');
      return ResponseChart.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }
}
