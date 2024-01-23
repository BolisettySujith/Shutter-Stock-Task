import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shutter_stocks_task/res/components/snack_bar_components.dart';

/// `InternetChecker`
/// This class contains a void method `observerNetwork` listen to the internet state
/// changes through out the app when it get started, and pop's required SnackBar to
/// indicate user on their current internet state

class InternetChecker {
  /// It helps not to show the snackbar when the app is launched and when the app is connected to internet
  /// otherwise if the app is launched when there is internet it still pop's a
  /// snack bar that they are connected to the internet, and that we didn't want to show to the user.
  /// once the app is initialized it changes true, so it can show's the snack bars afterwards
  /// FILE: `shutterstock_bloc.dart` helps in changing it to true
  ///    Line No: 38, 42, 45

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