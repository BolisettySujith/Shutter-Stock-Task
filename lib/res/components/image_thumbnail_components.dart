import 'package:flutter/material.dart';
import 'package:shutter_stocks_task/res/app_colors.dart';

/// This class contains all the components used by image's to display in the Home Page
class ImageThumbnailComponents {
  static BoxDecoration imageContainerBoxDecoration = BoxDecoration(
    color: AppColors.imageContainerBoxDecorationColor,
    borderRadius: BorderRadius.circular(8.0),
  );

  /// Placeholder widget show's up when the images is in loading state
  static Widget imageContainerPlaceholder = Container(
      color: AppColors.imageContainerPlaceholderContainerColor,
      height: 150,
      width: 50,
      child: const Icon(Icons.downloading)
  );

  /// Circular loading indicator appears when the user reaches at the
  /// end of the page while scrolling
  static Widget newDataLoadingIndicator = const SizedBox(
    height: 50,
    width: 50,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}