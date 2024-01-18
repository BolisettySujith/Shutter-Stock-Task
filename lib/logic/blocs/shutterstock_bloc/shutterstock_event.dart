import 'package:equatable/equatable.dart';

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


//TODO: Set Asset types
// TODO 1: Preview
// TODO 2: Small Thumb
// TODO 3: Large Thumb
// TODO 4: Huge Thumb
// TODO 5: Mosaic
// TODO 6: Preview 1000
// TODO 7: Preview 1500
