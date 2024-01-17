import 'package:shutter_stocks_task/data/dataproviders/shutterstock_api.dart';

import '../models/shutterStockModel/shutterstock_model.dart';

class ShutterStockRepository {

  Future<ShutterStockModel> getShutterStockImages(Map<String, dynamic> qParams) async {

    final dynamic rawImagesData = await ShutterStockAPI.instance.getRawSearchImages(qParams);
    final ShutterStockModel shutterStockModel = ShutterStockModel.fromJson(rawImagesData);

    return shutterStockModel;
  }
}