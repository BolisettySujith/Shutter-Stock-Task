import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  // API AUTH Key
  static final String apiAuthKey = "Basic ${dotenv.env["SHUTTER_STOCK_API_TOKEN"]}";

  // Title's
  static const String appTitle = 'Shutter Stock Task';
  static const String appBarTitleHomePage = "Shutter Stock Task";
  static const String noDataFoundText = "No Data Found";
  static const String imagesLoadingFromCacheText = "Loading images from cache";
  static const String imagesLoadingFromApiText = "Loading images from API";

  // Durations
  static const Duration connectTimeout = Duration(milliseconds: 10000);
  static const Duration receiveTimeout = Duration(milliseconds: 10000);

  static const Duration internetConnectedSnackBarDuration = Duration(seconds: 2);
  static const Duration noInternetSnackBarDuration = Duration(days: 1);
  static const Duration connectionTimeOutSnackBarDuration = Duration(days: 1);
  static const Duration somethingWentWrongSnackBarDuration = Duration(days: 1);

  // Asset types
  static const List<String> assetTypes = [
    "Preview",
    "Small Thumb",
    "Large Thumb",
    "Huge Thumb",
    "Mosaic",
    "Preview 1000",
    "Preview 1500"
  ];

  // Snack bar content's
  static const String somethingWentWrongSnackBarContent = "Something went wrong";
  static const String connectionTimeOutSnackBarContent = "Connection Timeout...";
  static const String noInternetSnackBarContent = "Offline Mode: No Internet\nPlease TURN ON Internet to get more images";
  static const String internetConnectedSnackBarContent = "Internet Connected";
}

enum ImgAssetTypes {
  preview,
  smallThumb,
  largeThumb,
  huge_thumb,
  mosaic,
  preview_1000,
  preview_1500
}