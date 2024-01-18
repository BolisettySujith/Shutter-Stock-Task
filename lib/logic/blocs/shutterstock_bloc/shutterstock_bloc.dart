import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_event.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_state.dart';
import '../../../data/repository/shutterstock_repository.dart';

class ShutterStockBloc extends Bloc<ShutterStockEvent, ShutterStockState>{
  
  final ShutterStockRepository _shutterStockRepository;
  int _pageNo = 1;
  
  ShutterStockBloc(this._shutterStockRepository) : super(ShutterStockInitialState()){
   on<GetShutterStockAPIImagesEvent>((event, emit) async {
     emit(ShutterStockRemoteImagesLoading());
     try {
       Map<String, dynamic> params = {
         'page' : _pageNo,
       };
       if(event.searchQuery != null) params["query"] = event.searchQuery;

       final ShutterStockModel shutterStockModel = await _shutterStockRepository.getShutterStockImagesFromAPI(params);
       _pageNo += 1;
       emit(ShutterStockImagesLoaded(shutterStockModel));

     } on DioException catch (e) {
       if(DioExceptionType.receiveTimeout == e.type || DioExceptionType.connectionTimeout == e.type) {
         if (kDebugMode) {
           print("Connection timeout");
         }
         emit(ConnectionTimeout());
       } else if(DioExceptionType.connectionError == e.type) {
         if (kDebugMode) {
           print("Not internet");
         }
         add(GetShutterStockLocalImagesEvent());
       }
       // print(e);
       // emit(NoInternet());
     } catch (e) {
       if (kDebugMode) {
         print(e);
       }
       emit(ShutterStockImagesLoadingFailed());
     }
   });

   on<GetShutterStockLocalImagesEvent>((event, emit) async {
     emit(ShutterStockLocalImagesLoading());
     try {
       Map<String, dynamic> params = {
         'page' : _pageNo,
       };
       if(event.searchQuery != null) params["query"] = event.searchQuery;

       final ShutterStockModel? shutterStockModel = await _shutterStockRepository.getShutterStockImagesFromLocal(params);
       if(shutterStockModel == null) {
         emit(NoShutterStockImagesFound());
       } else {
         _pageNo += 1;
         emit(ShutterStockImagesLoaded(shutterStockModel));
       }
     } catch (e) {
       if (kDebugMode) {
         print(e);
       }
       emit(ShutterStockImagesLoadingFailed());
     }
   });
  }
}