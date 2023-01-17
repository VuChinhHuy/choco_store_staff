import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/base_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class BasePage<C extends BaseController> extends GetWidget<C> {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.onInitState();
    return Obx(() => buildViewState(context));
  }

  Widget buildViewState(BuildContext context) {
    switch (controller.viewState.value) {
      case ViewState.error:
        // return DataErrorWidget(
        //   messageError: controller.dataException?.message,
        //   onReloadData: controller.onReloadData,
        // );
        return const Center(
          child: Text('Lỗi view'),
        );
      case ViewState.loaded:
      case ViewState.empty:
        return Stack(
          children: [
            buildContentView(context, controller),
            if (controller.viewState.value == ViewState.empty) buildEmptyView,
          ],
        );
      case ViewState.loading:
        return Stack(
          children: [
            buildContentView(context, controller),
            if (controller.viewState.value == ViewState.loading)
              buildLoadingView,
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget buildDefaultLoading() {
    return const SpinKitPouringHourGlassRefined(
        color: Color.fromARGB(255, 248, 195, 3));
  }

  Widget buildContentView(BuildContext context, C controller);

  Widget get buildLoadingView => buildDefaultLoading();

  Widget buildDefaultEmpty() => const SizedBox.shrink();

  Widget get buildEmptyView => buildDefaultEmpty(); //const DataEmptyWidget();
}

enum ViewState { initial, loading, loaded, empty, error }
