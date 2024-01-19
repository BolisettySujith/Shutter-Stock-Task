import 'package:equatable/equatable.dart';
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';

abstract class ShutterStockState extends Equatable {
  @override
  // TODO: implement props
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
  });
  
  final List<Datum> imagesData;


  
  ShutterStockImagesLoaded copyWith ({
      List<Datum>? imagesData
  }) {
    return ShutterStockImagesLoaded(
      imagesData: imagesData ?? this.imagesData
    );
  }

  @override
  // TODO: implement props
  List<Datum> get props => imagesData ?? [];
}

class ShutterStockImagesLoadingFailed extends ShutterStockState {}

class NoInternet extends ShutterStockState {}

class ConnectionTimeout extends ShutterStockState {}


class NoShutterStockImagesFound extends ShutterStockState {}
