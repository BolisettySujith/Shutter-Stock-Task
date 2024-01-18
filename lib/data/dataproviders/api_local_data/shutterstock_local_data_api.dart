import 'package:hive/hive.dart';
import '../../models/shutterStockModel/shutterstock_model.dart';
import '../boxes/shutterstock_local_boxes.dart';

class ShutterStockLocalDataAPI {

  ShutterStockLocalDataAPI._();

  static final ShutterStockLocalDataAPI _instance = ShutterStockLocalDataAPI._();

  static ShutterStockLocalDataAPI get instance => _instance;

  static final Box<ShutterStockModel> shutterStockBox = ShutterStockLocalBoxes.getShutterStockImagesData();


  Future<void> saveNewShutterStockImageData(Map<String, dynamic> qParams, ShutterStockModel newShutterStockModel) async {
    String dataKey = "page=${qParams["page"]}&query=${qParams["query"] ?? ""}";

    await shutterStockBox.put(dataKey, newShutterStockModel);
    await newShutterStockModel.save();

    // print("Length of the data: ${shutterStockBox.values.length}");
  }

  Future<ShutterStockModel?> getShutterStockImagesFromLocal(Map<String, dynamic> qParams) async {
    String dataKey = "page=${qParams["page"]}&query=${qParams["query"] ?? ""}";
    // print(dataKey);
    // print(shutterStockBox.values.length);
    final ShutterStockModel? shutterStockModel =  shutterStockBox.get(dataKey);
    return shutterStockModel;
  }

}