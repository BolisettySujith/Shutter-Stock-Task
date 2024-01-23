import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';
import 'data/repository/shutterstock_repository.dart';
import 'logic/blocs/shutterstock_bloc/shutterstock_bloc.dart';
import 'logic/blocs/shutterstock_bloc/shutterstock_event.dart';
import 'presentation/pages/home_page.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Loads the .env file
  await dotenv.load(fileName: ".env");

  // Hive initialization
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  // Registering the hive adapters
  Hive.registerAdapter(DatumAdapter());
  Hive.registerAdapter(AssetsAdapter());
  Hive.registerAdapter(HugeThumbAdapter());
  Hive.registerAdapter(ContributorAdapter());
  Hive.registerAdapter(SpellcheckInfoAdapter());
  Hive.registerAdapter(ShutterStockModelAdapter());

  // Open's the hive box
  await Hive.openBox<ShutterStockModel>("shutter_stock_api_data");

  runApp(const MyApp());
}

/// Parent Widget of the app which contains the Material App and the parent node
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        useMaterial3: true,
      ),
      // Adding the bloc provider at the parent node,
      home: BlocProvider<ShutterStockBloc>(
        // When created, it initially calls the `GetShutterStockAPIImagesEvent()`
        // to get the images data from the api when the app starts
        create: (context) => ShutterStockBloc(ShutterStockRepository())..add(GetShutterStockAPIImagesEvent()),
        child: const HomePage(),
      )
    );
  }
}