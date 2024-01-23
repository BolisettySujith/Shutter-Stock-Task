import 'package:flutter/material.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';

class NoDataFoundPage extends StatelessWidget {
  const NoDataFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(AppConstants.noDataFoundText),
      ),
    );
  }
}
