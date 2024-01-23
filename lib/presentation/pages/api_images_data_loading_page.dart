import 'package:flutter/material.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';

class ApiImagesDataLoadingPage extends StatelessWidget {
  const ApiImagesDataLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(AppConstants.imagesLoadingFromApiText)
          ],
        ),
      ),
    );
  }
}
