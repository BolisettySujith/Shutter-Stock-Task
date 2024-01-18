import 'package:shutter_stocks_task/data/dataproviders/api_data/shutterstock_api.dart';
import 'package:shutter_stocks_task/data/dataproviders/api_local_data/shutterstock_local_data_api.dart';
import '../models/shutterStockModel/shutterstock_model.dart';

class ShutterStockRepository {
  Future<ShutterStockModel> getShutterStockImagesFromAPI(Map<String, dynamic> qParams) async {
    final dynamic rawImagesData = await ShutterStockAPI.instance.getRawSearchImages(qParams);
    final ShutterStockModel shutterStockModel = ShutterStockModel.fromJson(rawImagesData);
    await saveNewShutterStockImageData(qParams, shutterStockModel);
    return shutterStockModel;
  }

  Future<void> saveNewShutterStockImageData(Map<String, dynamic> qParams, ShutterStockModel newShutterStockModel) async {
    await ShutterStockLocalDataAPI.instance.saveNewShutterStockImageData(qParams, newShutterStockModel);
  }

  Future<ShutterStockModel?> getShutterStockImagesFromLocal(Map<String, dynamic> qParams) async {
    final ShutterStockModel? shutterStockModel = await ShutterStockLocalDataAPI.instance.getShutterStockImagesFromLocal(qParams);
    return shutterStockModel;
  }
}