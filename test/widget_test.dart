// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';
import 'package:shutter_stocks_task/data/repository/shutterstock_repository.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_bloc.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_state.dart';
import 'package:mockito/mockito.dart';
import 'package:shutter_stocks_task/presentation/pages/home_page.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';

class MockShutterStockRepository extends Mock implements ShutterStockRepository {}

void main() {

  late ShutterStockBloc mockShutterStockBloc;
  late MockShutterStockRepository shutterStockRepository;

  setUp(() {
    shutterStockRepository = MockShutterStockRepository();
    mockShutterStockBloc = ShutterStockBloc(shutterStockRepository);

  });

  tearDown(() {
    mockShutterStockBloc.close();
  });

  testWidgets('Find deep items in the long list view', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockShutterStockBloc,
          child: const HomePage(),
        ),
      ),
    );
    
    // Simulate ShutterStockImagesLoaded state
    when(mockShutterStockBloc.state).thenReturn(
      ShutterStockImagesLoaded(
        imagesData: List.generate(70, (index) => Datum(assets: Assets())),
        imgAssetType: ImgAssetTypes.preview,
        hasMoreImageData: true
      )
    );
    // Scroll to the 63rd item
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey("ShutterStockImage_63")),
      500.0,
      maxScrolls: 6
    );

    // Wait for the scroll to settle
    await tester.pumpAndSettle();

    // Verify that the image with key "ShutterStockImage_63"
    expect(find.byKey(const ValueKey("ShutterStockImage_63")), findsOneWidget);

  });
}
