import 'package:hive/hive.dart';
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';

class ShutterStockLocalBoxes {
  static Box<ShutterStockModel>  getShutterStockImagesData() => Hive.box<ShutterStockModel>("shutter_stock_api_data");
}