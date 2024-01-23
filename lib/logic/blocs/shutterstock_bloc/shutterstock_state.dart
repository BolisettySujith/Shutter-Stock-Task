import 'package:equatable/equatable.dart';
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';

/// `ShutterStockState`
/// Using This abstract class, different states can be emitted
///
/// **Different States include:**
/// - ShutterStockInitialState
/// - ShutterStockRemoteImagesLoading
/// - ShutterStockLocalImagesLoading
/// - ShutterStockImagesLoaded
/// - ShutterStockImagesLoadingFailed
/// - NoInternet
/// - ConnectionTimeout
/// - NoShutterStockImagesFound
///

abstract class ShutterStockState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// `ShutterStockInitialState`
/// This state will be emitted in the initial state of the app
class ShutterStockInitialState extends ShutterStockState {}

/// `ShutterStockRemoteImagesLoading`
/// This state will be emitted when the BLoC fetches
/// the images data from the remote api
class ShutterStockRemoteImagesLoading extends ShutterStockState {}

/// `ShutterStockLocalImagesLoading`
/// This state will be emitted when the BLoC fetches
/// the images data from the hive database
class ShutterStockLocalImagesLoading extends ShutterStockState {}

/// `ShutterStockImagesLoaded`
/// This state will be emitted after the BLoC fetches
/// the images data from the remote shutter stock api or hive database
///
/// This contains three parameters:
/// - imagesData : List Datum
/// - imgAssetType : enum ImgAssetTypes
/// - hasMoreImageData : bool
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

/// `ShutterStockImagesLoadingFailed`
/// This state will be emitted when the BLoC failed to fetch
/// the images data from the hive database or api
class ShutterStockImagesLoadingFailed extends ShutterStockState {}

/// `NoInternet`
/// This state will be emitted when there is no internet connected to the mobile
class NoInternet extends ShutterStockState {}

/// `ConnectionTimeout`
/// This state will be emitted when the api tries to connect to
/// the api but it took longer than expected time to connect
class ConnectionTimeout extends ShutterStockState {}

/// `NoShutterStockImagesFound`
/// This state will be emitted when no images found from the cache or from the api
class NoShutterStockImagesFound extends ShutterStockState {}
