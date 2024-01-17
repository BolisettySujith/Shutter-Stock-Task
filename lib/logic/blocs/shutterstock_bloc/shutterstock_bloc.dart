import 'package:bloc/bloc.dart';
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_event.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_state.dart';

import '../../../data/repository/shutterstock_repository.dart';

class ShutterStockBloc extends Bloc<ShutterStockEvent, ShutterStockState>{
  
  final ShutterStockRepository _shutterStockRepository;
  int _pageNo = 1;
  
  ShutterStockBloc(this._shutterStockRepository) : super(ShutterStockInitialState()){
   on<GetShutterStockImagesEvent>((event, emit) async {
     emit(ShutterStockImagesLoading());
     try {
       Map<String, dynamic> params = {
         'page' : _pageNo,
       };
       if(event.searchQuery != null) params["query"] = event.searchQuery;

       final ShutterStockModel shutterStockModel = await _shutterStockRepository.getShutterStockImages(params);
       _pageNo += 1;
       emit(ShutterStockImagesLoaded(shutterStockModel));
     } catch (e) {
       print(e);
       emit(ShutterStockImagesLoadingFailed());
     }
   });
  }
}