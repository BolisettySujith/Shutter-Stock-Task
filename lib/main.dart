import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shutter_stocks_task/data/models/shutterStockModel/shutterstock_model.dart';
import 'presentation/pages/home_page.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Loads the .env file
  await dotenv.load(fileName: ".env");

  // Hive initialization
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(DatumAdapter());
  Hive.registerAdapter(AssetsAdapter());
  Hive.registerAdapter(HugeThumbAdapter());
  Hive.registerAdapter(ContributorAdapter());
  Hive.registerAdapter(SpellcheckInfoAdapter());
  Hive.registerAdapter(ShutterStockModelAdapter());
  await Hive.openBox<ShutterStockModel>("shutter_stock_api_data");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}