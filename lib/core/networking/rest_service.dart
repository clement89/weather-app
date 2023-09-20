import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather/core/logs/log_service.dart';
import 'package:weather/di/injection_container.dart';

class RestService {
  final int timeOut = 20;
  static const _baseUrl = 'http://api.weatherapi.com/v1';
//https://api.weatherapi.com/v1/current.json?q=London&key=4915ce97206946f69ae74642232009
//https://api.weatherapi.com/v1/current.json?q=9.796600%2C76.482231&key=4915ce97206946f69ae74642232009

  Future<Map<String, String>> _getAuthHeader() async {
    return {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
  }

  final logService = serviceLocator<LogService>();

  Future<ApiResponse> getDataFromServer({
    required String url,
    Map<String, String>? header,
  }) async {
    logService.logInfo('GET --------- ${_baseUrl + url}');
    Map<String, String> header0 = await _getAuthHeader();
    try {
      http.Response response = await http.get(
        Uri.parse(_baseUrl + url),
        headers: {
          ...header0,
          ...?header,
        },
      ).timeout(Duration(seconds: timeOut), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      logService.logInfo('statue code --- ${response.statusCode}');

      // logService.logInfo('data --- ${response.body}');

      if (response.statusCode == 200) {
        // var data = json.decode(response.body.toString()) as dynamic;

        if (response.body.isEmpty) {
          return ApiResponse(isError: false, data: response.body);
        }

        var data = json.decode(utf8.decode(response.bodyBytes)) as dynamic;

        return ApiResponse(isError: false, data: data);
      } else {
        String msg = '';
        try {
          var data = json.decode(utf8.decode(response.bodyBytes)) as dynamic;
          msg = data['message'] ?? 'Error getting response from server';
        } catch (e) {
          // dPrint('Error - > $e');
        }
        return ApiResponse(
          isError: true,
          errorMessage: msg,
        );
      }
    } on SocketException {
      return ApiResponse(
        isError: true,
        errorMessage: 'No internet connection',
      );
    } on TimeoutException catch (_) {
      return ApiResponse(
        isError: true,
        errorMessage: 'The connection has timed out, Please try again!',
      );
    }
  }
}

class ApiResponse {
  bool isError;
  String? errorMessage;
  dynamic data;

  ApiResponse({
    required this.isError,
    this.errorMessage,
    this.data,
  });
}
