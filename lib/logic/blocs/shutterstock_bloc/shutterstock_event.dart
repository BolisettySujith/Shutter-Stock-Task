import 'package:equatable/equatable.dart';

abstract class ShutterStockEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetShutterStockImagesEvent extends ShutterStockEvent {
  final String? searchQuery;

  GetShutterStockImagesEvent({this.searchQuery});

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
