import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_bloc.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_event.dart';
import 'package:shutter_stocks_task/res/app_colors.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';

class SnackBarComponents {
  static void somethingWentWrongSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppConstants.somethingWentWrongSnackBarContent),
          duration: AppConstants.somethingWentWrongSnackBarDuration,
          backgroundColor: AppColors.greenSnackBarBackGroundColor,
          behavior: SnackBarBehavior.floating,
        )
    );
  }

  static void connectionTimeOutSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppConstants.connectionTimeOutSnackBarContent,
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<ShutterStockBloc>(context).add(GetShutterStockAPIImagesEvent());
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: const Icon(Icons.refresh),
              )
            ],
          ),
          duration: AppConstants.connectionTimeOutSnackBarDuration,
          backgroundColor: AppColors.greySnackBarBackGroundColor,
          behavior: SnackBarBehavior.floating,
        )
    );
  }

  static void noInternetSnackBar(BuildContext context) {
    SnackBar sb = const SnackBar(
      content: Text(AppConstants.noInternetSnackBarContent),
      duration: AppConstants.noInternetSnackBarDuration,
      backgroundColor: AppColors.redSnackBarBackGroundColor,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
    );

    ScaffoldMessenger.of(context).showSnackBar(sb);
  }

  static void internetConnectedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppConstants.internetConnectedSnackBarContent),
          duration: AppConstants.internetConnectedSnackBarDuration,
          backgroundColor: AppColors.greenSnackBarBackGroundColor,
          behavior: SnackBarBehavior.floating,
        )
    );
  }
}