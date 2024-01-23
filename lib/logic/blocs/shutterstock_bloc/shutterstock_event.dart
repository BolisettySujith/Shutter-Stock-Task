import 'package:equatable/equatable.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';

/// `ShutterStockEvent`
/// Using This abstract class, different states can be emitted
///
/// **Different Events include:**
/// - GetShutterStockAPIImagesEvent
/// - GetShutterStockLocalImagesEvent
/// - ChangeAssetTypeEvent
/// - ResetShutterStockImagesEvent
abstract class ShutterStockEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// `GetShutterStockAPIImagesEvent`
/// When a new images data need to get, this event will be triggered.
/// This event also contains a string i.e a searchQuery
/// which helps in getting the images related to the query
class GetShutterStockAPIImagesEvent extends ShutterStockEvent {
  final String? searchQuery;

  GetShutterStockAPIImagesEvent({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

/// `GetShutterStockLocalImagesEvent`
/// This event will be triggered when there is no internet connection
/// When Local images data need to get, this event will be triggered.
/// This event also contains a string i.e a searchQuery
/// which helps in getting the images related to the query
class GetShutterStockLocalImagesEvent extends ShutterStockEvent {
  final String? searchQuery;

  GetShutterStockLocalImagesEvent({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

/// `ChangeAssetTypeEvent`
/// This event will be triggered when the user wants to change the asset type
/// in the home page app bar PopUpMenuItem
/// This event also contains a assetType of enum type ImgAssetTypes
class ChangeAssetTypeEvent extends ShutterStockEvent {
  final ImgAssetTypes assetType;

  ChangeAssetTypeEvent(this.assetType);

  @override
  List<Object?> get props => [assetType];
}

/// `GetShutterStockLocalImagesEvent`
/// This event will be triggered when the user done PullToRefresh in the home page
/// This get new images data and refreshes the old data
/// This event also contains a string i.e a searchQuery
/// which helps in getting the images related to the query
class ResetShutterStockImagesEvent extends ShutterStockEvent {
  final String? searchQuery;

  ResetShutterStockImagesEvent({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}