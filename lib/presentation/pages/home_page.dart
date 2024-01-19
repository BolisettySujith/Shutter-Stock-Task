import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_bloc.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_event.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom) {
      // User has reached the bottom of the list, trigger an event to load more data
      // BlocProvider.of<ShutterStockBloc>(context).add(GetShutterStockAPIImagesEvent());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shutter Stock Image Viewer"),
        elevation: 2,
      ),
      body: BlocConsumer<ShutterStockBloc, ShutterStockState>(
        listener: (context, shutterState){
          // Show's this screen when error occurred in the process
          if(shutterState is ShutterStockImagesLoadingFailed) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Something went wrong"),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                )
            );
          }
          if(shutterState is ConnectionTimeout) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Connection Timeout...",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<ShutterStockBloc>(context).add(GetShutterStockAPIImagesEvent());
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        child: const Icon(Icons.refresh),
                      )
                    ],
                  ),
                  duration: const Duration(days: 1),
                  backgroundColor: Colors.grey,
                  behavior: SnackBarBehavior.floating,
                )
            );
          }
          // Show's this circular loading screen when the app initially fetching the data
        },
        builder: (context, shutterState){
          // Show's this screen when images loaded successfully
          if(shutterState is ShutterStockImagesLoaded) {
            print("Total Images in Grid : ${shutterState.imagesData.length.toString()}");
            return SafeArea(
              child: GridView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8.0, // Spacing between columns
                  mainAxisSpacing: 8.0, // Spacing between rows
                ),
                itemCount: shutterState.imagesData.length+1,
                itemBuilder: (BuildContext context, int index) {
                  final imageUrl = shutterState.imagesData[index].assets?.largeThumb?.url;
                  if((index == shutterState.imagesData.length) || (index == shutterState.imagesData.length+1)) {
                    return Container(
                      color: Colors.black45,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return imageUrl != null
                  ? Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.downloading)
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  )
                      : Container();
                },
              )
            );
          }
          // Show's this screen when there is no internet
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
          // Show's this screen when the local data is begin loading
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
          // Show's this screen when there are not Stock images found
          if(shutterState is NoShutterStockImagesFound) {
            return const SafeArea(
              child: Center(
                child: Text("No data Found from the cache"),
              ),
            );
          }
          // Show's this screen when there is a connection time out

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
    );
  }
}
