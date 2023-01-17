import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:choco_store_staff/ui/base_page.dart';
import 'package:choco_store_staff/ui/home/home_page.dart';
import 'package:choco_store_staff/ui/sales/order_save_no_pay.dart/order_save_no_pay.dart';
import 'package:choco_store_staff/ui/sales/sales_controller.dart';
import 'package:choco_store_staff/ui/widget/product_item_in_listview.dart';
import 'package:choco_store_staff/utils/dimens.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/logger_debug/flutter_logger.dart';
import '../widget/data_empty_widget.dart';

class SalesPage extends BasePage<SalesController> {
  const SalesPage({Key? key}) : super(key: key);
  EdgeInsets get padding => EdgeInsets.symmetric(horizontal: 0, vertical: 0.w);

  double get itemSpacing => 0;

  Color get dividerColor => const Color.fromARGB(211, 15, 142, 142);
  Color get background => const Color.fromARGB(13, 236, 247, 247);

  @override
  Widget buildContentView(BuildContext context, SalesController controller) {
    return Scaffold(
      body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: Get.height, maxHeight: Get.height),
              child: IntrinsicHeight(
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 20.h),
                    child: AnimSearchBar(
                      textController: controller.textSearch,
                      width: Get.width,
                      // closeSearchOnSuffixTap: true,
                      color: const Color.fromRGBO(28, 103, 88, 100),
                      style: GoogleFonts.acme(
                          color: const Color.fromARGB(255, 213, 238, 214),
                          fontSize: 18.sp),
                      rtl: true,
                      autoFocus: false,
                      onSuffixTap: () {
                        controller.textSearch.clear();
                      },
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: Get.width,
                        maxHeight: 600.h,
                        minHeight: 500.h,
                        minWidth: Get.width),
                    color: background,
                    child: (controller.items.isNotEmpty)
                        ? CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            controller: controller.scrollController,
                            slivers: [
                              CupertinoSliverRefreshControl(
                                onRefresh: controller.enableRefresh
                                    ? controller.onRefresh
                                    : null,
                                builder: (_, __, a1, a2, a3) {
                                  return Container(
                                      alignment: Alignment.center,
                                      child:
                                          const SpinKitPouringHourGlassRefined(
                                              color: Color.fromARGB(
                                                  201, 64, 171, 18)));
                                },
                              ),
                              SliverPadding(
                                padding: padding,
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return Column(
                                        children: [
                                          ProductItem(
                                              product: controller.items[index],
                                              addCard: () => controller.addCard(
                                                  controller.items[index]),
                                              viewStoreDiff: () =>
                                                  controller.viewStoreDiff(
                                                      controller.items[index])),
                                          Divider(
                                              height: itemSpacing,
                                              color: dividerColor)
                                        ],
                                      );
                                    },
                                    childCount: controller.items.length,
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: controller.isLoadMore.value
                                    ? Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, top: 10),
                                        alignment: Alignment.center,
                                        child:
                                            const SpinKitPouringHourGlassRefined(
                                                color: Color.fromARGB(
                                                    201, 64, 171, 18)))
                                    : const SizedBox(),
                              ),
                            ],
                          )
                        : DataEmptyWidget(background: background),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                  title: "Hoá đơn chưa hoàn thành",
                                  radius: 30.w,
                                  content: Obx(() => Container(
                                          child: OrderSaveNoPayList(
                                        items: controller.listOrderNoSave.value,
                                        deletedItem: (p0) {
                                          controller
                                              .removeItemsInListNoSave(p0);
                                          controller.listOrderNoSave.refresh();
                                        },
                                        choseItem:
                                            (Map<dynamic, dynamic> order) {
                                          if (controller.listOrder.isNotEmpty) {
                                            final map = <String, dynamic>{};
                                            map['order'] = controller.listOrder;
                                            controller.storage
                                                .saveListOrder(map);
                                          }
                                          controller.listOrder.value =
                                              (order['order'] as List)
                                                  .map((e) => e
                                                      as Map<dynamic, dynamic>)
                                                  .toList();

                                          controller.removeItemsInListNoSave(
                                              controller.listOrderNoSave
                                                  .indexOf(order));
                                          Get.back();
                                        },
                                      ))));
                            },
                            child: Container(
                              width: 76.w,
                              height: 76.w,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.list_alt_outlined,
                                          size: 55.w,
                                          color: const Color.fromARGB(
                                              226, 4, 57, 27)),
                                      Text('Hoá đơn',
                                          style: GoogleFonts.chivo(
                                              color: const Color.fromARGB(
                                                  226, 4, 57, 27)),
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.h, vertical: 2.w),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                      alignment: Alignment.center,
                                      child: Obx(() => Text(controller
                                          .countListOrder.value
                                          .toString())),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.toPageOrderSale();
                            },
                            child: Container(
                              width: 76.w,
                              height: 76.w,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.shopping_bag,
                                          size: 55.w,
                                          color: const Color.fromARGB(
                                              226, 4, 57, 27)),
                                      Text('Giỏ hàng',
                                          style: GoogleFonts.chivo(
                                              color: const Color.fromARGB(
                                                  226, 4, 57, 27)),
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.h, vertical: 2.w),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                      alignment: Alignment.center,
                                      child: Obx(() => Text(controller
                                          .listOrder.value.length
                                          .toString())),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                  )

                  // Expanded(child: ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount))
                ],
              )))),
      // floatingActionButton:
      //     IconButton(icon: Icon(Icons.favorite), onPressed: () => jumpToTop()),
    );
  }

  jumpToTop() {
    controller.scrollController.animateTo(
      0.0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
