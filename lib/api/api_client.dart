import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:screen_decor/utils/shared_preference_helper.dart';
import 'api_response.dart';
import 'app_exceptions.dart';

class ApiClient {
  final String _baseUrl = "http://52.65.173.187/v1/";
  final String _host = "http://52.65.173.187";
  static const String requestOtp = "auth/requestotp";
  static const String verifyOtp = "auth/varifyotp";
  static const String register = "auth/register";
  static const String getCategories = "category/";
  static const String getProductList = "product/";
  static const String addToCart = "cart/";
  static const String getCartList = "cart/";
  static const String addOutlet = "outlet/";
  static const String getCuisines = "outlet/cuisines";
  static const String placeOrder = "order/";
  static const String submitPayment = "/order/payment";
  static const String cafeProfile = "profile/";
  static const String updateBusinessProfile = "profile/";
  static const String getOrderHistory = "order/";

  Future<T> get<T, K>(String url, String path, {dynamic queryParams}) async {
    print('Api Get, url ${_baseUrl + url}');
    var responseJson;
    try {
      String token = await SharedPreferencesHelper.getAccessToken();
      Map<String, String> headers = new Map();
      headers.addAll({"Content-Type": "application/x-www-form-urlencoded"});
      if (token != null) {
        headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
        print("---accesToken----$token---------");
      }
      Uri uri = Uri.parse(_baseUrl + url);
      final newURI = uri.replace(queryParameters: queryParams);
//      final urlEncoded = Uri.encodeFull('$url/$path');
//      var uri = Uri.http(_baseUrl, urlEncoded, queryParams);
      print("------uri------$newURI------------");
      final response =
          await http.get(newURI.toString().trim(), headers: headers);
      responseJson = _returnResponse<T, K>(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<T> post<T, K>(
      String url, bool isJsonBodyType, Map<String, dynamic> body,
      {dynamic queryParams}) async {
    print('Api Post, url ${_baseUrl + url}');
    var responseJson;
    try {
      String token = await SharedPreferencesHelper.getAccessToken();
      print("---accesToken----$token---------");
      Map<String, String> headers = new Map();
      headers.addAll({"Content-Type": "application/x-www-form-urlencoded"});

      if (token != null) {
        headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      }

      var jsonBody = json.encode(body);

      print("------------body--------$jsonBody-----------");

      var response;
      if (isJsonBodyType) {
        Map<String, String> headersJson = new Map();
        headers.addAll({
          'Content-Type': 'application/json',
          'accept': 'application/json',
        });

        if (token != null) {
          headersJson = {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json"
          };
        }

        response = await http.post(_baseUrl + url,
            headers: headersJson, body: jsonBody);
      } else {
        Uri uri = Uri.parse(_baseUrl + url);
        final newURI = uri.replace(queryParameters: queryParams);
        print("------uri------$newURI------------");
        response = await http.post(newURI, body: body, headers: headers);
      }
      responseJson = _returnResponse<T, K>(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    } on Exception {
      print('Exception');
    }
    print('api post.');
    return responseJson;
  }

  Future<T> patch<T, K>(String url, Map<String, dynamic> body) async {
    print('Api Put, url ${_baseUrl + url}');
    var responseJson;
    try {
      final response = await http.patch(_baseUrl + url, body: body, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${await SharedPreferencesHelper.getAccessToken()}'
      });
      responseJson = _returnResponse<T, K>(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<T> put<T, K>(String url, Map<String, dynamic> body) async {
    print('Api put, url ${_baseUrl + url}');
    var responseJson;
    try {
      final response = await http.put(_baseUrl + url, body: body, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${await SharedPreferencesHelper.getAccessToken()}'
      });
      responseJson = _returnResponse<T, K>(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<T> delete<T, K>(String url) async {
    print('Api delete, url ${_baseUrl + url}');
    var apiResponse;
    try {
      final response = await http.delete(_baseUrl + url, headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${await SharedPreferencesHelper.getAccessToken()}'
      });
      apiResponse = _returnResponse<T, K>(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }

  Future<T> _returnResponse<T, K>(http.Response response) async {
    var responseJson = json.decode(response.body.toString());
    print(responseJson);
    ApiResponse apiResponse = ApiResponse<T, K>();
    apiResponse = apiResponse.fromJson(responseJson);
    if (apiResponse.message.contains("Your OTP")) {
      List<String> otpList = apiResponse.message.split(".");
      String otp = otpList[1];
//      await SharedPreferencesHelper.setOtp(otp);
      print("----------otp-----------$otp----------");
    }
    switch (response.statusCode) {
      case 200:
        if (apiResponse.error != null) {
          throw FetchDataException(apiResponse.message);
        }
        return apiResponse.data;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
