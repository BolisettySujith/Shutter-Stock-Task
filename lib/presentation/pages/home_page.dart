import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shutter_stocks_task/data/repository/shutterstock_repository.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_bloc.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_event.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShutterStockBloc>(
      create: (context) => ShutterStockBloc(ShutterStockRepository())..add(GetShutterStockImagesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shutter Stock Image Viewer"),
          elevation: 2,
        ),
        body: BlocConsumer<ShutterStockBloc, ShutterStockState>(
          listener: (context, shutterState){

          },
          builder: (context, shutterState){
            if(shutterState is ShutterStockImagesLoaded) {
              return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text("Images Loaded Successfully"),
                          Text(shutterState.shutterStockModel.data!.length.toString())
                        ],
                      ),
                    ),
                  )
              );
            }
            if(shutterState is ShutterStockImagesLoadingFailed) {
              return const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text("Failed"),
                    ),
                  )
              );
            }
            return const SafeArea(
              child: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
