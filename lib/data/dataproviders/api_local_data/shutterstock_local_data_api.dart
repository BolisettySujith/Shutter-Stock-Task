import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shutter_stocks_task/data/dataproviders/boxes/shutterstock_local_boxes.dart';
import '../../models/shutterStockModel/shutterstock_model.dart';

/// `ShutterStockLocalDataAPI`
/// It is a singleton class
/// It contains the method `saveNewShutterStockImageData` to save the data to the local db(cache)
/// It contains the method `getShutterStockImagesFromLocal` to retrieve the data from the local db(cache)
class ShutterStockLocalDataAPI {

  ShutterStockLocalDataAPI._();

  static final ShutterStockLocalDataAPI _instance = ShutterStockLocalDataAPI._();

  static ShutterStockLocalDataAPI get instance => _instance;

  static final Box<ShutterStockModel> shutterStockBox = ShutterStockLocalBoxes.getShutterStockImagesData();


  Future<void> saveNewShutterStockImageData(Map<String, dynamic> qParams, ShutterStockModel newShutterStockModel) async {
    // This dataKey will the key to the images data that need to be saved in the hive database,
    // This dataKey will again helps in retrieving the particular saved data from the hive database
    // The dataKey is generated with the combination of the query parameters from the api
    // Eg dataKey: `page=1&per_page=10&query=`
    String dataKey = "page=${qParams["page"]}&per_page=${qParams["per_page"]}&query=${qParams["query"] ?? ""}";

    // This keep the dataKey as the key and the newShutterStockModel as the value
    await shutterStockBox.put(dataKey, newShutterStockModel);
    await newShutterStockModel.save(); // .save() helps in saving the data to the hive db(cache)
    if (kDebugMode) {
      print("Data saved successfully with key : $dataKey");
    }
  }

  Future<ShutterStockModel?> getShutterStockImagesFromLocal(Map<String, dynamic> qParams) async {
    // This dataKey will helps in retrieving the particular saved data from the hive database
    // The dataKey is generated with the combination of the query parameters from the api
    // Eg dataKey: `page=1&per_page=10&query=`
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