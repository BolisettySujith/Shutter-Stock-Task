import 'package:equatable/equatable.dart';
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';

abstract class ShutterStockState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShutterStockInitialState extends ShutterStockState {}

class ShutterStockRemoteImagesLoading extends ShutterStockState {}

class ShutterStockLocalImagesLoading extends ShutterStockState {}

class ShutterStockImagesLoaded extends ShutterStockState {
  // final ShutterStockModel shutterStockModel;
  ShutterStockImagesLoaded({
    // this.shutterStockModel,
    this.imagesData = const <Datum>[],
    this.imgAssetType = ImgAssetTypes.preview,
    this.hasMoreImageData = true,
  });
  
  final List<Datum> imagesData;
  final ImgAssetTypes imgAssetType;
  final bool hasMoreImageData;
  
  ShutterStockImagesLoaded copyWith ({
      List<Datum>? imagesData,
      ImgAssetTypes? imgAssetType,
      bool? hasMoreImageData
  }) {
    return ShutterStockImagesLoaded(
      imagesData: imagesData ?? this.imagesData,
      imgAssetType: imgAssetType ?? this.imgAssetType,
      hasMoreImageData: hasMoreImageData ?? this.hasMoreImageData
    );
  }

  @override
  List<Object?> get props => [imagesData, imgAssetType, hasMoreImageData];
}

class ShutterStockImagesLoadingFailed extends ShutterStockState {}

class NoInternet extends ShutterStockState {}

class ConnectionTimeout extends ShutterStockState {}


class NoShutterStockImagesFound extends ShutterStockState {}
