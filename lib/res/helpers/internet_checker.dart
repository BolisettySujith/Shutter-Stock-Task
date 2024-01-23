import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shutter_stocks_task/res/components/snack_bar_components.dart';

class InternetChecker {
  static bool appInit = false;

  static void observeNetwork({BuildContext? context, Function? callback}) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none) {
        SnackBarComponents.noInternetSnackBar(context!);
      } else {
        if(appInit == true){
          SnackBarComponents.internetConnectedSnackBar(context!);
          callback?.call();
        }
      }
    });
  }
}