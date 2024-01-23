import 'package:hive/hive.dart';
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';

/// `ShutterStockLocalBoxes`
/// All the local hive boxes can be accessed through this `ShutterStockLocalBoxes` class
class ShutterStockLocalBoxes {
  static Box<ShutterStockModel>  getShutterStockImagesData() => Hive.box<ShutterStockModel>("shutter_stock_api_data");
}