import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:choco_store_staff/data/api/model/reponse/profile/profile_store.dart';
import 'package:choco_store_staff/data/api/model/reponse/sales/product_in_inventory.dart';
import 'package:choco_store_staff/data/api/service/store_service.dart';
import 'package:choco_store_staff/data/repositories/product_repository.dart';
import 'package:choco_store_staff/ui/order_sales/order_sales_binding.dart';
import 'package:choco_store_staff/ui/order_sales/order_sales_page.dart';
import 'package:choco_store_staff/utils/date_time_utils.dart';
import 'package:choco_store_staff/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_quantity/input_quantity.dart';
import '../../controller/base_controller.dart';
import '../../data/storage/app_storage.dart';
import '../../utils/logger_debug/flutter_logger.dart';
import '../home/home_page.dart';

class SalesController extends BaseController {
  TextEditingController textSearch = TextEditingController();

  final productRepository = Get.find<ProductRepository>();

  final storeRe = Get.find<StoreSerivce>();

  final storage = Get.find<AppStore>();

  late ScrollController scrollController = ScrollController();

  late RxList<ProductInInventory> items = <ProductInInventory>[].obs;

  bool get enableRefresh => true;

  bool continueLoadMore = true;

  double get rangeLoadMore => 500;

  RxBool isLoadMore = false.obs;

  RxInt countListOrder = 0.obs;

  late List<ProductInInventory> listpro;

  RxList<Map> listOrder = RxList<Map>();
  RxList listOrderNoSave = RxList();
  @override
  void onInit() async {
    super.onInit();
    textSearch.addListener(_textSearchChange);
    scrollController = ScrollController()..addListener(_scrollListener);
    await getData();
  }

  loadData() async {
    final list = await storage.getListOrder();
    listOrderNoSave.value = list;
    list.isEmpty
        ? countListOrder.value = 0
        : countListOrder.value = list.length;
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter == rangeLoadMore &&
        continueLoadMore) {
      // loadMoreData();
    }
  }

  _textSearchChange() async {
    showLoading();

    Logger.d('Text Search: ${textSearch.text}');

    // ignore: unrelated_type_equality_checks
    if (textSearch.text.isEmpty || textSearch.value == "") {
      items.value = listpro;
    } else {
      var listSearch = listpro
          .where((x) => x.product!.name!
              .toString()
              .toLowerCase()
              .contains(textSearch.text.toLowerCase()))
          .toList();
      items.value = listSearch;
    }
    showEmpty();
  }

  removeItemsInListNoSave(int itemRemove) async {
    await storage.removeListOrder(itemRemove);
    loadData();
  }

  @override
  void onClose() {
    super.onClose();
    textSearch.dispose();
    if (listOrder.isNotEmpty) {
      final map = <String, dynamic>{};
      map['order'] = listOrder;
      storage.saveListOrder(map);
    }
  }

  @override
  void dispose() {
    super.dispose();
    textSearch.dispose();
    if (listOrder.isNotEmpty) {
      final map = <String, dynamic>{};
      map['order'] = listOrder;
      storage.saveListOrder(map);
    }
  }

  getData() async {
    final pro = await productRepository.getProductInVentory();
    items.value = pro;
    listpro = pro;
    await loadData();
  }

  addCard(ProductInInventory product) {
    Logger.d("Add Card: ${product.product!.name}");
    final List<Image> images = [
      ...product.product!.image!.map<Image>(
          (img) => Image.memory(base64.decode(img.src!.split(',').last)))
    ];
    ProductInInventory productNew = ProductInInventory();
    productNew.product = product.product;
    productNew.count = 1;
    showModalBottomSheet(
      context: Get.context!,
      // isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: Get.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: Get.width.w,
                height: 50.h,
                child: Card(
                    color: const Color.fromARGB(184, 2, 49, 40),
                    semanticContainer: true,
                    elevation: 12.w,
                    // margin: EdgeInsets.all(10.h),
                    shadowColor: const Color.fromRGBO(28, 103, 88, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.w),
                            topRight: Radius.circular(20.w))),
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Text(
                        product.product!.name!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.anton(
                            fontSize: 16.sp, color: Colors.white),
                      ),
                    )),
              ),
              SizedBox(
                height: 20.h,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.w,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                items: images,
              ),
              SizedBox(
                  height: 20.h,
                  child: const Divider(color: Color.fromARGB(244, 4, 71, 71))),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Giá:',
                          style: GoogleFonts.chivo(
                              fontSize: 18.sp,
                              color: const Color.fromARGB(244, 4, 71, 71)),
                        ),
                      ),
                      Text(
                          '${formatPrice(product.product!.price!.toDouble())} vnd',
                          style: GoogleFonts.chivo(
                              fontSize: 18.sp,
                              color: const Color.fromARGB(255, 14, 60, 60)))
                    ],
                  )),
              SizedBox(
                height: 10.h,
              ),
              Container(
                  width: Get.width.w,
                  height: 45.h,
                  padding: EdgeInsets.only(top: 10.h, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: 103.w,
                          height: 45.h,
                          child: InputQty(
                            maxVal: listpro
                                .toList()
                                .firstWhere((element) =>
                                    element.product!.id! ==
                                    product.product!.id!)
                                .count!,
                            initVal: 1,
                            minVal: 1,
                            steps: 1,
                            isIntrinsicWidth: true,
                            borderShape: BorderShapeBtn.none,
                            plusBtn: const Icon(Icons.add_box),
                            minusBtn: const Icon(Icons.indeterminate_check_box),
                            btnColor1: Colors.teal,
                            btnColor2: Colors.red,
                            onQtyChanged: (val) {
                              productNew.count = val as int;
                            },
                          )),
                      Expanded(
                          child: Center(
                              child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(138, 14, 60, 60)),
                        child: Text(
                          "Thêm vào đơn",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        onPressed: () {
                          listOrder.value.add(productNew.toJson());
                          listOrder.refresh();
                        },
                      )))
                    ],
                  )),
              SizedBox(
                height: 25.h,
              ),
              Expanded(
                  child: GestureDetector(
                      onTap: () async {
                        await toPageOrderSale();
                      },
                      child: Card(
                        color: const Color.fromARGB(222, 243, 240, 242),
                        semanticContainer: true,
                        elevation: 8.w,
                        // margin: EdgeInsets.all(10.h),
                        shadowColor: const Color.fromRGBO(28, 103, 88, 100),
                        child: Row(
                          children: [
                            Icon(Icons.local_mall,
                                size: 35.h,
                                color:
                                    const Color.fromARGB(227, 214, 140, 140)),
                            Obx(() => Text(
                                  "${listOrder.length} Sản phẩm",
                                  style: GoogleFonts.chivo(
                                      fontSize: 16.sp,
                                      color:
                                          const Color.fromARGB(226, 4, 57, 27)),
                                )),
                          ],
                        ),
                      )))
            ],
          )),
    );
  }

  toPageOrderSale() async {
    var data = await Get.to(const OrderSalesPage(),
        binding: OrderSalesBinding(), arguments: listOrder);
    if (data.toString().contains("Success")) {
      listOrder.value = [];
      Get.back();
      getData();
    }
  }

  viewStoreDiff(ProductInInventory product) async {
    Logger.d("View Store: ${product.product!.name}");
    List listproduct = await productRepository
        .getProductInStoreDiff(product.product!.id.toString()) as List;
    // List listproduct = await productRepository
    //     .getProductInStoreDiff('6327943f1e31c138d45667c5') as List;
    RxList list = [].obs;
    if (listproduct.isNotEmpty) {
      List<Map<String, dynamic>> listStore = [];
      listproduct.toList().forEach((element) async {
        ProfileStore store =
            await storeRe.getStore(element["idStore"].toString());
        Map<String, dynamic> map = {"store": store, "count": element["count"]};
        listStore.add(map);
      });
      list.value = listStore;
    }
    showLoading();
    await Future.delayed(const Duration(seconds: 3));
    Get.defaultDialog(
        title: "${product.product!.name}",
        textCancel: "Cancel",
        buttonColor: const Color.fromARGB(200, 12, 37, 1),
        barrierDismissible: false,
        radius: 30.w,
        content: list.isNotEmpty
            ? SizedBox(
                height: 500.h, // Change as per your requirement
                width: 300.w,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Card(
                        elevation: 10.w,
                        shadowColor: const Color.fromARGB(192, 4, 71, 71),
                        color: const Color.fromARGB(84, 189, 240, 240),
                        child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${list.value[index]["store"].nameStore}",
                                    softWrap: true,
                                    style: GoogleFonts.anton(
                                        fontSize: 18.sp,
                                        color: const Color.fromARGB(
                                            192, 4, 71, 71))),
                                SizedBox(
                                    height: 15.h,
                                    width: Get.width - 200.w,
                                    child: const Divider(
                                        color: Color.fromARGB(244, 4, 71, 71))),
                                Text("${list.value[index]["store"].address}",
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.chivo(
                                        fontSize: 16.sp,
                                        color: const Color.fromARGB(
                                            192, 4, 71, 71))),
                                SizedBox(
                                    height: 15.h,
                                    width: Get.width - 100.w,
                                    child: const Divider(
                                        color: Color.fromARGB(244, 4, 71, 71))),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text("Số lượng: ",
                                            softWrap: true,
                                            style: GoogleFonts.chivo(
                                                fontSize: 16.sp,
                                                color: const Color.fromARGB(
                                                    192, 4, 71, 71)))),
                                    Expanded(
                                        child: Text(
                                            "${list.value[index]["count"]}",
                                            softWrap: true,
                                            style: GoogleFonts.chivo(
                                                fontSize: 18.sp,
                                                color: const Color.fromARGB(
                                                    235, 71, 4, 63))))
                                  ],
                                )
                              ],
                            ))),
                    separatorBuilder: (_, __) => Divider(
                          height: 2.h,
                          color: Colors.black,
                        ),
                    itemCount: list.length))
            : Text(
                "Không có sản phẩm ở cửa hàng khác",
                style: GoogleFonts.chivo(),
              ));

    showEmpty();
  }

  Future<void> onRefresh({dynamic params}) async {
    await getData();
  }
}
