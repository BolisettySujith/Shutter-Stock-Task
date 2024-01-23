import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shutter_stocks_task/data/dataproviders/boxes/shutterstock_local_boxes.dart';
import '../../models/shutterStockModel/shutterstock_model.dart';


class ShutterStockLocalDataAPI {

  ShutterStockLocalDataAPI._();

  static final ShutterStockLocalDataAPI _instance = ShutterStockLocalDataAPI._();

  static ShutterStockLocalDataAPI get instance => _instance;

  static final Box<ShutterStockModel> shutterStockBox = ShutterStockLocalBoxes.getShutterStockImagesData();


  Future<void> saveNewShutterStockImageData(Map<String, dynamic> qParams, ShutterStockModel newShutterStockModel) async {
    String dataKey = "page=${qParams["page"]}&per_page=${qParams["per_page"]}&query=${qParams["query"] ?? ""}";
    await shutterStockBox.put(dataKey, newShutterStockModel);
    await newShutterStockModel.save();
    if (kDebugMode) {
      print("Data saved successfully with key : $dataKey");
    }
    // print("Length of the data: ${shutterStockBox.values.length}");
  }

  Future<ShutterStockModel?> getShutterStockImagesFromLocal(Map<String, dynamic> qParams) async {
    String dataKey = "page=${qParams["page"]}&per_page=${qParams["per_page"]}&query=${qParams["query"] ?? ""}";
    if (kDebugMode) {
      print(dataKey);
    }
    final ShutterStockModel? shutterStockModel =  shutterStockBox.get(dataKey);
    if (kDebugMode) {
      print(shutterStockModel?.data?.length);
    }
    return shutterStockModel;
  }

}