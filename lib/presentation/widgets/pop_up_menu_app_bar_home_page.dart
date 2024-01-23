import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_bloc.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_event.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_state.dart';
import 'package:shutter_stocks_task/res/app_colors.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';

/// `PopUpMenuAppBarHomePage`
/// This stateful widget is used in the home page app bar for showing the PopUpMenuItems
/// This PopUpMenuItems contains different types of Image Asset types
/// User can choose any of the asset type, based on his preference the ListView.builder
/// in the home page shows assets of that particular preferred asset type

class PopUpMenuAppBarHomePage extends StatefulWidget {
  const PopUpMenuAppBarHomePage({super.key});

  @override
  State<PopUpMenuAppBarHomePage> createState() => _PopUpMenuAppBarHomePageState();
}

class _PopUpMenuAppBarHomePageState extends State<PopUpMenuAppBarHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShutterStockBloc, ShutterStockState>(
        builder: (context, shutterState){
          if(shutterState is ShutterStockImagesLoaded) {
            return PopupMenuButton<int>(
              itemBuilder: (BuildContext context) => AppConstants.assetTypes.asMap().entries.map((entry) {
                int index = entry.key;
                String type = entry.value;
                return PopupMenuItem(
                  value: index,
                  labelTextStyle: MaterialStateTextStyle.resolveWith((states) {
                    return TextStyle(
                        fontWeight: shutterState.imgAssetType == ImgAssetTypes.values[index] ? FontWeight.bold : FontWeight.normal,
                        color: AppColors.popUpMenuLabelTextColor
                    );
                  }),
                  onTap: () {
                    BlocProvider.of<ShutterStockBloc>(context).add(ChangeAssetTypeEvent(ImgAssetTypes.values[index]));
                  },
                  child: Wrap(
                    children: [
                      Text(type),
                      const SizedBox(width: 2,),
                      shutterState.imgAssetType == ImgAssetTypes.values[index]
                        ? const Icon(
                          Icons.check,
                          size: 10,
                          color: AppColors.checkIconPopUpMenuItemColor
                        )
                        : const SizedBox()
                    ],
                  ),
                );
              }).toList(),
            );
          }
          return Container();
        }
    );
  }
}
