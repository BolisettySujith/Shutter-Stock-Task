import 'package:shutter_stocks_task/data/dataproviders/api_data/shutterstock_api.dart';
import 'package:shutter_stocks_task/data/dataproviders/api_local_data/shutterstock_local_data_api.dart';
import '../models/shutterStockModel/shutterstock_model.dart';

/// `ShutterStockRepository`
/// This repository will be the point of contact with the BLoC to access the
/// data either from the cache or from the shutter stock api

class ShutterStockRepository {
  /// This will connect with the `ShutterStockAPI` to make an api call to get the
  /// images data
  Future<ShutterStockModel> getShutterStockImagesFromAPI(Map<String, dynamic> qParams) async {
    final dynamic rawImagesData = await ShutterStockAPI.instance.getRawSearchImages(qParams);
    final ShutterStockModel shutterStockModel = ShutterStockModel.fromJson(rawImagesData);
    await saveNewShutterStockImageData(qParams, shutterStockModel);
    return shutterStockModel;
  }

  /// This will connect to the `ShutterStockLocalDataAPI` and helps in saving
  /// the data fetched from the shutter stock api with the help of the query parameters
  Future<void> saveNewShutterStockImageData(Map<String, dynamic> qParams, ShutterStockModel newShutterStockModel) async {
    await ShutterStockLocalDataAPI.instance.saveNewShutterStockImageData(qParams, newShutterStockModel);
  }

  // This will connect to the `ShutterStockLocalDataAPI` and helps in getting 
  // the data based on the query parameters
  Future<ShutterStockModel?> getShutterStockImagesFromLocal(Map<String, dynamic> qParams) async {
    final ShutterStockModel? shutterStockModel = await ShutterStockLocalDataAPI.instance.getShutterStockImagesFromLocal(qParams);
    return shutterStockModel;
  }
}