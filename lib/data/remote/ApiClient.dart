import 'dart:io';

import 'package:dio/dio.dart';
import 'package:multiservice/data/prefs/PreferencesManager.dart';
import 'package:multiservice/utils/log_utils.dart';

class ApiClient {
  static bool apiDebuggin = true;
  static Dio dio;

  static Dio getClient() {
    if (dio == null) {
      BaseOptions baseOptions = BaseOptions(
        baseUrl: "http://api.pencilmein.site/api/v1/",
        connectTimeout: 20000,
        receiveTimeout: 20000,
        contentType: ContentType.json,
        responseType: ResponseType.json,
      );

      dio = Dio(baseOptions);

      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          String jwt = PreferencesManager.getPref(PreferencesManager.JWT);

          if (jwt != null && jwt.length > 0)
            options.headers['Authorization'] = "Bearer ${jwt}";

          options.headers['Platform'] = Platform.isAndroid ? "Android" : "IOS";
          return options;
        },
        onResponse: (Response response) {
          if (apiDebuggin) {
            debugDioResponse(response);
          }
          return response; // continue
        },
        onError: (DioError e) {
          if (apiDebuggin) {
            debugDioError(e);
          }
          return e; //continue
        },
      ));
    }
    return dio;
  }

  static void debugDioError(DioError error) {
    print("+++++++++++++++Request++++++++++++++++++++");
    print("Url - " + error.request.baseUrl + error.request.path);
    print("Type - " + error.request.method);
    LogPrint("Headers - " + error.request.headers.toString());
    LogPrint("Request - " + error.request.data.toString());
    LogPrint("QueryParameters - " + error.request.queryParameters.toString());
    print("+++++++++++++++++++++++++++++++++++");

    if (error.response != null) {
      print("+++++++++++++++Response++++++++++++++++++++");
      print("Response Code - " + error.response.statusCode.toString());
      print("Response - " + error.response.data.toString());
      print("+++++++++++++++++++++++++++++++++++");
    } else {
      print("+++++++++++++++Response NULL++++++++++++++++++++");
    }

    print("+++++++++++++++Stack Trace++++++++++++++++++++");
    print("StackTrace - " + error.toString());
    print("+++++++++++++++++++++++++++++++++++");
  }

  static void debugDioResponse(Response response) {
    print("+++++++++++++++Request++++++++++++++++++++");
    print("Url - " + response.request.baseUrl + response.request.path);
    print("Type - " + response.request.method);
    LogPrint("Headers - " + response.request.headers.toString());
    LogPrint("Request - " + response.request.data.toString());
    LogPrint(
        "QueryParameters - " + response.request.queryParameters.toString());
    print("+++++++++++++++++++++++++++++++++++");

    print("+++++++++++++++Response++++++++++++++++++++");
    print("Response Code - " + response.statusCode.toString());
    LogPrint("Response - " + response.data.toString());
    print("+++++++++++++++++++++++++++++++++++");
  }
}
