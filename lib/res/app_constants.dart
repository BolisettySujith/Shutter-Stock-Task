import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String apiAuthKey = "Basic ${dotenv.env["SHUTTER_STOCK_API_TOKEN"]}";

  static const Duration connectTimeout = Duration(milliseconds: 10000);
  static const Duration receiveTimeout = Duration(milliseconds: 10000);
}