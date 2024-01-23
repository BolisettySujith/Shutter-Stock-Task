import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';
import 'package:shutter_stocks_task/res/app_urls.dart';

class ShutterStockAPI {
  late Dio _dio;
  static bool isInitialized = false;

  ShutterStockAPI._privateConstructor() {
    _initializeAPI();
  }

  static final ShutterStockAPI _instance = ShutterStockAPI._privateConstructor();

  //Singleton instance
  static ShutterStockAPI get instance => _instance;

  Future<void> _initializeAPI() async {
    if(!isInitialized) {
      try {
        _dio = Dio(
          BaseOptions(
            baseUrl: AppUrls.baseUrl,
            connectTimeout: AppConstants.connectTimeout,
            receiveTimeout: AppConstants.receiveTimeout,
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
          InterceptorsWrapper(
              onRequest: (options, handler) {
                options.headers["Authorization"] = AppConstants.apiAuthKey;
                options.headers["Content-Type"] = 'application/json; charset=UTF-8';
                return handler.next(options);
              }
          ),
        ]);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    isInitialized = true;
  }

  Future<dynamic> getRawSearchImages(Map<String, dynamic> qParams) async {
    await _initializeAPI();
    dynamic rawImages = {};
    final response = await _dio.get(
        AppUrls.searchImageEndPoint,
        queryParameters: qParams
    );

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      rawImages = response.data;
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print("Bad request");
      }
    } else if (response.statusCode == 401) {
      if (kDebugMode) {
        print("unauthorized");
      }
    } else if (response.statusCode == 404) {
      if (kDebugMode) {
        print("Not Found");
      }
    }
    return rawImages;
  }
}