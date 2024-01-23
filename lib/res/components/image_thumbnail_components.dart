import 'package:flutter/material.dart';
import 'package:shutter_stocks_task/res/app_colors.dart';

class ImageThumbnailComponents {
  static BoxDecoration imageContainerBoxDecoration = BoxDecoration(
    color: AppColors.imageContainerBoxDecorationColor,
    borderRadius: BorderRadius.circular(8.0),
  );

  static Widget imageContainerPlaceholder = Container(
      color: AppColors.imageContainerPlaceholderContainerColor,
      height: 150,
      width: 50,
      child: const Icon(Icons.downloading)
  );

  static Widget newDataLoadingIndicator = const SizedBox(
    height: 50,
    width: 50,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}