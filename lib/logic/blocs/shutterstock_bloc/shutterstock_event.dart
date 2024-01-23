import 'package:equatable/equatable.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';

abstract class ShutterStockEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetShutterStockAPIImagesEvent extends ShutterStockEvent {
  final String? searchQuery;

  GetShutterStockAPIImagesEvent({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class GetShutterStockLocalImagesEvent extends ShutterStockEvent {
  final String? searchQuery;

  GetShutterStockLocalImagesEvent({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class ChangeAssetTypeEvent extends ShutterStockEvent {
  final ImgAssetTypes assetType;

  ChangeAssetTypeEvent(this.assetType);

  @override
  List<Object?> get props => [assetType];
}

class ResetShutterStockImages extends ShutterStockEvent {
  final String? searchQuery;

  ResetShutterStockImages({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}