import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';
import 'package:shutter_stocks_task/res/app_urls.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

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

      var cacheDir = await getTemporaryDirectory();
      var cacheStore = HiveCacheStore(
        cacheDir.path,
        hiveBoxName: "shutter_stock_api_data",
      );

      var customCacheOptions = CacheOptions(
        store: cacheStore,
        policy: CachePolicy.forceCache,
        priority: CachePriority.high,
        maxStale: const Duration(minutes: 1),
        hitCacheOnErrorExcept: [401, 404],
        keyBuilder: (request) {
          // print(request.uri);
          return request.uri.toString();
        },
        allowPostMethod: false,

      );

      final options = CacheOptions(
        store: cacheStore,
        policy: CachePolicy.forceCache,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(days: 7),
        priority: CachePriority.normal,
        cipher: null,
        keyBuilder: (request) {
          // print(request.uri);
          return request.uri.toString();
        },
        allowPostMethod: false,
      );

      try {
        _dio = Dio(
          BaseOptions(
            baseUrl: AppUrls.baseUrl,
            connectTimeout: AppConstants.connectTimeout,
            receiveTimeout: AppConstants.receiveTimeout,
            // responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
          DioCacheInterceptor(options: customCacheOptions),
          InterceptorsWrapper(
              onRequest: (options, handler) {
                options.headers["Authorization"] = AppConstants.apiAuthKey;
                options.headers["Content-Type"] = 'application/json; charset=UTF-8';
                return handler.next(options);
              }
          ),
        ]);
      } catch (e) {
        print(e);
      }

    }
    isInitialized = true;
  }

  Future<dynamic> getRawSearchImages(Map<String, dynamic> qParams) async {
    await _initializeAPI();
    final response = await _dio.get(
      AppUrls.searchImageEndPoint,
      queryParameters: qParams
    );
    // print(response);
    dynamic rawWeather = response.data;
    return rawWeather;
  }
}