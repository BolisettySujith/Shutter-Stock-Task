import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_event.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_state.dart';
import 'package:shutter_stocks_task/res/app_urls.dart';
import 'package:shutter_stocks_task/res/helpers/internet_checker.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../data/repository/shutterstock_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';


EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ShutterStockBloc extends Bloc<ShutterStockEvent, ShutterStockState>{
  
  final ShutterStockRepository _shutterStockRepository;
  int _pageNo = 1;
  
  ShutterStockBloc(this._shutterStockRepository) : super(ShutterStockInitialState()){
   on<GetShutterStockAPIImagesEvent>((event, emit) async {
     if (_pageNo==1) emit(ShutterStockRemoteImagesLoading());

     final connectivityResult = await (Connectivity().checkConnectivity());
     if (connectivityResult == ConnectivityResult.none && _pageNo == 1) {
       InternetChecker.appInit = true;
       emit(NoInternet());
       add(GetShutterStockLocalImagesEvent());
     } else if(connectivityResult == ConnectivityResult.none && _pageNo != 1){
       InternetChecker.appInit = true;
       add(GetShutterStockLocalImagesEvent());
     } else {
       InternetChecker.appInit = true;
       try {
         Map<String, dynamic> params = {
           'page' : _pageNo,
           'per_page' : AppUrls.imagesPerPage
         };

         // Checks if there is any search query given by the user
         if(event.searchQuery != null) params["query"] = event.searchQuery;

         // Connects with the Shutter stock Repository to get the data from the API
         final ShutterStockModel shutterStockModel = await _shutterStockRepository.getShutterStockImagesFromAPI(params);
         final List<Datum>? imagesData = shutterStockModel.data;
         if (kDebugMode) {
           print("$_pageNo : ${imagesData?.length}");
         }

         // Check whether the state is ShutterStockImagesLoaded and page no is not 1
         // if the above condition satisfies, it proceeds to send the combined
         // data back to the grid screen and increments the page no
         if(state is ShutterStockImagesLoaded && _pageNo != 1) {
           ShutterStockImagesLoaded shutterStockImagesLoaded = state as ShutterStockImagesLoaded;
           if(imagesData != null) {
             _pageNo += 1;
           }

           return emit(shutterStockImagesLoaded.copyWith(
               imagesData: List.of(shutterStockImagesLoaded.imagesData)..addAll(imagesData ?? <Datum>[]),
               imgAssetType: shutterStockImagesLoaded.imgAssetType,
               hasMoreImageData: imagesData == null ? false : true
           ));
         }

         // This will only execute when the page no is 1, and
         // > If the the api didn't response any data
         // it will show NoShutterStockImagesFound screen
         // > Else it will increment the page no and send the images data
         // back to the grid screen
         if(imagesData == null) {
           emit(NoShutterStockImagesFound());
         } else {
           _pageNo += 1;
           emit(ShutterStockImagesLoaded(imagesData: imagesData));
         }
       } on DioException catch (e) {
         // > If
         // If Connection timeout happened in the request, it will show an
         // Connection time out screen
         // --------------------------
         // > Else If
         // If the exception is an connection error it indicates there is not
         // internet connection so it will try to get the data from the local
         // hive database of that particular page
         if(DioExceptionType.receiveTimeout == e.type || DioExceptionType.connectionTimeout == e.type) {
           if (kDebugMode) {
             print("Connection timeout");
           }
           emit(ConnectionTimeout());
           add(GetShutterStockLocalImagesEvent());
         } else if(DioExceptionType.connectionError == e.type) {
           if (kDebugMode) {
             print("Not internet");
           }
           add(GetShutterStockLocalImagesEvent());
         }
       } catch (e) {
         if (kDebugMode) {
           print(e);
         }
         emit(ShutterStockImagesLoadingFailed());
       }
     }

   },
   transformer: throttleDroppable(const Duration(milliseconds: 100)),
   );

   on<GetShutterStockLocalImagesEvent>((event, emit) async {
     if (_pageNo==1) emit(ShutterStockLocalImagesLoading());
     try {
       Map<String, dynamic> params = {
         'page' : _pageNo,
         'per_page' : AppUrls.imagesPerPage
       };
       // Checks if there is any search query given by the user
       if(event.searchQuery != null) params["query"] = event.searchQuery;

       // Connects with the Shutter stock Repository to get the data from the local hive data base
       final ShutterStockModel? shutterStockModel = await _shutterStockRepository.getShutterStockImagesFromLocal(params);
       final List<Datum>? imagesData = shutterStockModel?.data;
       if (kDebugMode) {
         print("$_pageNo : ${imagesData?.length}");
         print(state);
       }


       // Check whether the state is ShutterStockImagesLoaded and page no is not 1
       // if the above condition satisfies, it proceeds to send the combined
       // data back to the grid screen and increments the page no
       if(state is ShutterStockImagesLoaded && _pageNo != 1) {
         ShutterStockImagesLoaded shutterStockImagesLoaded = state as ShutterStockImagesLoaded;
         if (kDebugMode) {
           print("has images data");
           print(imagesData == null ? false : true);
         }

         if(imagesData != null) {
           _pageNo += 1;
         }
         return emit(shutterStockImagesLoaded.copyWith(
             imagesData: List.of(shutterStockImagesLoaded.imagesData)..addAll(imagesData ?? <Datum>[]),
             imgAssetType: shutterStockImagesLoaded.imgAssetType,
             hasMoreImageData: imagesData != null ? true : false
         ));
       }

       // This will only execute when the page no is 1, and
       // > If the the api didn't response any data
       // it will show NoShutterStockImagesFound screen
       // > Else it will increment the page no and send the images data
       // back to the grid screen

       if(imagesData == null) {
         emit(NoShutterStockImagesFound());
       } else {
         _pageNo += 1;
         emit(ShutterStockImagesLoaded(imagesData: imagesData));
       }
     } catch (e) {
       if (kDebugMode) {
         print(e);
       }
       emit(ShutterStockImagesLoadingFailed());
     }
   },
   transformer: throttleDroppable(const Duration(milliseconds: 100)),
   );

   on<ChangeAssetTypeEvent>((event, emit) async {
     if(state is ShutterStockImagesLoaded && _pageNo != 1) {
       ShutterStockImagesLoaded shutterStockImagesLoaded = state as ShutterStockImagesLoaded;
       return emit(shutterStockImagesLoaded.copyWith(
           imagesData: shutterStockImagesLoaded.imagesData,
           imgAssetType: event.assetType,
       ));
     }
   });

   on<ResetShutterStockImages>((event, emit) async {
     _pageNo = 1;
     if (_pageNo==1) emit(ShutterStockRemoteImagesLoading());
     try {
       Map<String, dynamic> params = {
         'page' : _pageNo,
         'per_page' : AppUrls.imagesPerPage
       };

       // Checks if there is any search query given by the user
       if(event.searchQuery != null) params["query"] = event.searchQuery;

       // Connects with the Shutter stock Repository to get the data from the API
       final ShutterStockModel shutterStockModel = await _shutterStockRepository.getShutterStockImagesFromAPI(params);
       final List<Datum>? imagesData = shutterStockModel.data;
       if (kDebugMode) {
         print("$_pageNo : ${imagesData?.length}");
       }

       // Check whether the state is ShutterStockImagesLoaded and page no is not 1
       // if the above condition satisfies, it proceeds to send the combined
       // data back to the grid screen and increments the page no
       if(state is ShutterStockImagesLoaded && _pageNo != 1) {
         ShutterStockImagesLoaded shutterStockImagesLoaded = state as ShutterStockImagesLoaded;
         if(imagesData != null) {
           _pageNo += 1;
         }
         return emit(shutterStockImagesLoaded.copyWith(
            imagesData: List.of(shutterStockImagesLoaded.imagesData)..addAll(imagesData ?? <Datum>[]),
            imgAssetType: shutterStockImagesLoaded.imgAssetType,
            hasMoreImageData: imagesData == null ? false : true
         ));
       }

       // This will only execute when the page no is 1, and
       // > If the the api didn't response any data
       // it will show NoShutterStockImagesFound screen
       // > Else it will increment the page no and send the images data
       // back to the grid screen
       if(imagesData == null) {
         emit(NoShutterStockImagesFound());
       } else {
         _pageNo += 1;
         emit(ShutterStockImagesLoaded(imagesData: imagesData));
       }
     } on DioException catch (e) {
       // > If
       // If Connection timeout happened in the request, it will show an
       // Connection time out screen
       // --------------------------
       // > Else If
       // If the exception is an connection error it indicates there is not
       // internet connection so it will try to get the data from the local
       // hive database of that particular page
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
     } catch (e) {
       if (kDebugMode) {
         print(e);
       }
       emit(ShutterStockImagesLoadingFailed());
     }
   },
     transformer: throttleDroppable(const Duration(milliseconds: 100)),
   );
  }
}