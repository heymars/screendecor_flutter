import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:screen_decor/common/constants.dart';
import 'package:screen_decor/utils/shared_preference_helper.dart';

import 'api_response.dart';
import 'app_exceptions.dart';

class ApiClient {
  static const String getPhotos = "/photos";

  Future<T> get<T, K>(String url, {dynamic queryParams}) async {
    print('Api Get, url ${Constants.BASE_API_URL + url}');
    var responseJson;
    try {
      String token = Constants.ACCESS_KEY;
      Map<String, String> headers = new Map();
      headers.addAll({"Content-Type": "application/x-www-form-urlencoded"});
      if (token != null) {
        headers = {HttpHeaders.authorizationHeader: 'Client-ID $token'};
        print("---accesToken----$token---------");
      }
      Uri uri = Uri.parse(Constants.BASE_API_URL + url);
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
    print('Api Post, url ${Constants.BASE_API_URL + url}');
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

        response = await http.post(Constants.BASE_API_URL + url,
            headers: headersJson, body: jsonBody);
      } else {
        Uri uri = Uri.parse(Constants.BASE_API_URL + url);
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
    print('Api Put, url ${Constants.BASE_API_URL + url}');
    var responseJson;
    try {
      final response =
          await http.patch(Constants.BASE_API_URL + url, body: body, headers: {
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
    print('Api put, url ${Constants.BASE_API_URL + url}');
    var responseJson;
    try {
      final response =
          await http.put(Constants.BASE_API_URL + url, body: body, headers: {
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
    print('Api delete, url ${Constants.BASE_API_URL + url}');
    var apiResponse;
    try {
      final response =
          await http.delete(Constants.BASE_API_URL + url, headers: {
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
