import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_bloc.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_event.dart';
import 'package:shutter_stocks_task/logic/blocs/shutterstock_bloc/shutterstock_state.dart';
import 'package:shutter_stocks_task/presentation/pages/api_images_data_loading_page.dart';
import 'package:shutter_stocks_task/presentation/pages/local_images_data_loading_page.dart';
import 'package:shutter_stocks_task/presentation/pages/no_data_page.dart';
import 'package:shutter_stocks_task/presentation/widgets/pop_up_menu_app_bar_home_page.dart';
import 'package:shutter_stocks_task/res/app_constants.dart';
import 'package:shutter_stocks_task/res/components/image_thumbnail_components.dart';
import 'package:shutter_stocks_task/res/components/snack_bar_components.dart';
import 'package:shutter_stocks_task/res/helpers/internet_checker.dart';

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
    InternetChecker.observeNetwork(
        context: context,
        callback: () => BlocProvider.of<ShutterStockBloc>(context).add(ResetShutterStockImages())
    );
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
      BlocProvider.of<ShutterStockBloc>(context).add(GetShutterStockAPIImagesEvent());
    }
  }

  Future<void> refreshData() async {
    BlocProvider.of<ShutterStockBloc>(context).add(ResetShutterStockImages());
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appBarTitleHomePage),
        elevation: 10,
        actions: const [
          PopUpMenuAppBarHomePage()
        ],
      ),
      body: BlocConsumer<ShutterStockBloc, ShutterStockState>(
        listener: (context, shutterState){
          // Show's this screen when error occurred in the process
          if(shutterState is ShutterStockImagesLoadingFailed) {
            SnackBarComponents.somethingWentWrongSnackBar(context);
          }
          // Show's this screen when there is a connection time out
          if(shutterState is ConnectionTimeout) {
            SnackBarComponents.connectionTimeOutSnackBar(context);
          }
          // Show's this screen when there is no internet
          if(shutterState is NoInternet) {
            SnackBarComponents.noInternetSnackBar(context);
          }

        },
        builder: (context, shutterState){
          // Show's this screen when images loaded successfully
          if(shutterState is ShutterStockImagesLoaded) {
            if (kDebugMode) {
              print("Total Images in Grid : ${shutterState.imagesData.length.toString()}");
            }

            return RefreshIndicator(
                key: refreshIndicatorKey,
                onRefresh: () => refreshData(),
                child: SafeArea(
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: (shutterState.imagesData.length+ (shutterState.hasMoreImageData ? 1 : 0)),
                      itemBuilder: (BuildContext context, int index) {
                        if((index == shutterState.imagesData.length && shutterState.hasMoreImageData == true)) {
                          return ImageThumbnailComponents.newDataLoadingIndicator;
                        }

                        String? imageUrl = "";
                        switch(shutterState.imgAssetType) {
                          case ImgAssetTypes.preview :
                            imageUrl = shutterState.imagesData[index].assets?.preview?.url;
                            break;
                          case ImgAssetTypes.smallThumb:
                            imageUrl = shutterState.imagesData[index].assets?.smallThumb?.url;
                            break;
                          case ImgAssetTypes.largeThumb:
                            imageUrl = shutterState.imagesData[index].assets?.largeThumb?.url;
                            break;
                          case ImgAssetTypes.huge_thumb:
                            imageUrl = shutterState.imagesData[index].assets?.hugeThumb?.url;
                            break;
                          case ImgAssetTypes.mosaic:
                            imageUrl = shutterState.imagesData[index].assets?.mosaic?.url;
                            break;
                          case ImgAssetTypes.preview_1000:
                            imageUrl = shutterState.imagesData[index].assets?.preview1000?.url;
                            break;
                          case ImgAssetTypes.preview_1500:
                            imageUrl = shutterState.imagesData[index].assets?.preview1500?.url;
                            break;
                        }

                        return imageUrl != null
                          ? Container(
                            margin: const EdgeInsets.all(8),
                            height: 150,
                            width: 50,
                            decoration: ImageThumbnailComponents.imageContainerBoxDecoration,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => ImageThumbnailComponents.imageContainerPlaceholder,
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          )
                          : Container();
                      },
                    )
                ),
            );
          }

          // Show's this screen when there are not Stock images found
          if(shutterState is NoShutterStockImagesFound) return const NoDataFoundPage();

          // Show's this screen when the local data is begin loading
          if(shutterState is ShutterStockLocalImagesLoading) return const LocalImagesDataLoadingPage();

          // Show's this circular loading screen when the app initially fetching the data
          return const ApiImagesDataLoadingPage();
        },
      ),
    );
  }
}
