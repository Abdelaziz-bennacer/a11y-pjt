import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../config/app_information.dart';
import '../../global/ui/utils/dialog_util.dart';
import '../errors/app_exceptions.dart';

abstract class NetworkHandler {
  static final client = Dio();
  static final baseUrl = AppConstants.dbBaseUrl;
  static final timeOutDuration = 20;
  //static final storage = FlutterSecureStorage();

  static String buildUrl(String endPoint) {
    final apiPath = '$baseUrl' + '$endPoint';
    print('BUILDERURL: $apiPath');
    return apiPath;
  }

  static Future<void> storeToken(String token) async {
    //await storage.write(key: "token", value: token);
  }

  static Future<String?> getToken() async {
    //return await storage.read(key: "token");
  }

  static dynamic processResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 201:
      case 202:
        var responseJson = response.data;
        return responseJson;
      case 400:
        //throw DioErrorType.other;
        return BadRequestException(response.data, response.realUri.toString());
      case 401:
      case 403:
        return UnAuthorizedException(
            response.data, response.realUri.toString(),
        );
      case 405:
        return 'Method not allowed';
      case 500:
      default:
        return FetchDataException(
            'Erroroccured with code: ${response.statusCode}',
            response.realUri.toString());
    }
  }

  static Future<dynamic> put(var body, String endPoint, [String jwtToken = '']) async {
    try {
      var response = await client.put(
        buildUrl(endPoint),
        data: body,
        queryParameters: {
          "Content-type": "application/json",
          //"Accept": "application/json",
          "authorization": "Bearer $jwtToken"
        },
      ).timeout(Duration(seconds: timeOutDuration));
      print('Response: $response');
      print('RESPONSE-JWT: ${response}');
      //storeToken(response.data["jwt"]);
      //return response.data;
      return processResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connexion', '$baseUrl$endPoint');
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', '$baseUrl$endPoint');
    } on BadRequestException catch(e) {
      DialogUtil.showErrorDialog(e.message!);
    }
  }

  static Future<dynamic> post(var body, String endPoint,
      [String jwtToken = '']) async {
    try {
      var response = await client.post(
        buildUrl(endPoint),
        data: body,
        queryParameters: {
          "Content-type": "application/json",
          //"Accept": "application/json",
          "authorization": "Bearer $jwtToken"
        },
      ).timeout(Duration(seconds: timeOutDuration));
      print('Response: $response');
      print('RESPONSE-JWT: ${response}');
      //storeToken(response.data["jwt"]);
      //return response.data;
      return processResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connexion', '$baseUrl$endPoint');
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', '$baseUrl$endPoint');
    } on BadRequestException catch(e) {
      DialogUtil.showErrorDialog(e.message!);
    }
    /* on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
        throw e;
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    } */
  }

  static Future<dynamic> get(String endPoint, [String jwtToken = '']) async {
    try {
      var response = await client.get(
        buildUrl(endPoint),
        queryParameters: {
          "Content-type": "application/json",
          //"Accept": "application/json",
          "authorization": "Bearer $jwtToken"
        },
      ).timeout(Duration(seconds: timeOutDuration));
      //print('Response: $response');

      //storeToken(response.data["jwt"]);
      //return response.data;

      return processResponse(response);

      
    } on SocketException {
      throw FetchDataException('No internet connexion', '$baseUrl$endPoint');
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', '$baseUrl$endPoint');
    } on BadRequestException catch(e){
      DialogUtil.showErrorDialog(e.message!);
    }
  }
}