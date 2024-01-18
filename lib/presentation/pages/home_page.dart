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
      create: (context) => ShutterStockBloc(ShutterStockRepository())..add(GetShutterStockAPIImagesEvent()),
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
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: [
                          const Text("Images Loaded Successfully"),
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
            if(shutterState is NoInternet) {
              return const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text("No Internet"),
                    ),
                  )
              );
            }
            if(shutterState is ShutterStockLocalImagesLoading) {
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
                      Text("Loading images from cache")
                    ],
                  ),
                ),
              );
            }
            if(shutterState is NoShutterStockImagesFound) {
              return const SafeArea(
                child: Center(
                  child: Text("No data Found from the cache"),
                ),
              );
            }
            if(shutterState is ConnectionTimeout) {
              return SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      const Text("Connection Timeout, please try again"),
                      ElevatedButton(
                        onPressed: (){
                          BlocProvider.of<ShutterStockBloc>(context).add(GetShutterStockAPIImagesEvent());
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
              );
            }
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
                    Text("Loading images from API")
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
