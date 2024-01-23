import 'package:flutter/material.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';

/// `NoDataFoundPage`
/// this stateless widget is shown when there is no data from the data layer
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
