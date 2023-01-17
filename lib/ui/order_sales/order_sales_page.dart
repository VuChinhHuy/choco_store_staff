import 'dart:convert';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:choco_store_staff/ui/order_sales/customer/customer_list_view.dart';
import 'package:choco_store_staff/ui/order_sales/order_sales_controller.dart';
import 'package:choco_store_staff/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../utils/date_time_utils.dart';
import '../base_page.dart';

class OrderSalesPage extends BasePage<OrderSalesController> {
  const OrderSalesPage({Key? key}) : super(key: key);

  @override
  Widget buildContentView(
      BuildContext context, OrderSalesController controller) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(211, 255, 255, 255),
          title: Text("THANH TOÁN & THÊM ĐƠN",
              style: GoogleFonts.unicaOne(
                  color: const Color.fromARGB(255, 2, 45, 4),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold)),
        ),
        body: Obx(
          () => controller.listOrder.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/warning_error.svg',
                        width: 200.w,
                        height: 200.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("Không có sản phẩm",
                          style: GoogleFonts.prostoOne(
                              color: const Color.fromARGB(223, 4, 60, 60),
                              fontSize: 22.sp)),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(223, 4, 60, 60)),
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("TRỞ VỀ")),
                          )),
                    ],
                  ),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                  child: Column(children: [
                    Container(
                        constraints: BoxConstraints(
                            maxHeight: 450.h,
                            minHeight: 300.h,
                            maxWidth: Get.width),
                        child: Obx(
                          () => ListView.separated(
                              itemBuilder: (context, index) {
                                final List<Image> images = [
                                  ...controller.listOrder
                                      .value[index]["product"]["image"]
                                      .map<Image>((img) => Image.memory(base64
                                          .decode(img['src']!.split(',').last)))
                                ];
                                return Container(
                                    width: 335.w,
                                    height: 130.h,
                                    child: Card(
                                      elevation: 15.w,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.w))),
                                      semanticContainer: true,
                                      color: const Color.fromRGBO(
                                          227, 235, 247, 1),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 82.w,
                                            height: 130.h,
                                            child: CarouselSlider(
                                              options: CarouselOptions(
                                                autoPlay: true,
                                                aspectRatio: 2.w,
                                                enlargeCenterPage: true,
                                                enlargeStrategy:
                                                    CenterPageEnlargeStrategy
                                                        .height,
                                              ),
                                              items: images,
                                            ),
                                          ),
                                          Container(
                                              width: 220.w,
                                              child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 15.h),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Obx(() => Text(
                                                            "${controller.listOrder[index]['product']['name']}",
                                                            softWrap: true,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.unicaOne(
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    2,
                                                                    45,
                                                                    4),
                                                                fontSize: 22.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Obx(() => Text(
                                                            "${formatPrice(controller.listOrder[index]['product']['price'].toDouble())} vnd")),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        InputQty(
                                                          maxVal: 50,
                                                          initVal: controller
                                                                  .listOrder
                                                                  .value[index]
                                                              ['count'],
                                                          minVal: 1,
                                                          steps: 1,
                                                          isIntrinsicWidth:
                                                              true,
                                                          borderShape:
                                                              BorderShapeBtn
                                                                  .none,
                                                          plusBtn: const Icon(
                                                              Icons.add_box),
                                                          minusBtn: const Icon(Icons
                                                              .indeterminate_check_box),
                                                          btnColor1:
                                                              Colors.teal,
                                                          btnColor2: Colors.red,
                                                          onQtyChanged: (val) {
                                                            controller.listOrder
                                                                        .value[
                                                                    index]
                                                                ['count'] = val;
                                                            controller
                                                                .calculatorTotal();
                                                          },
                                                        )
                                                      ]))),
                                          IconButton(
                                              onPressed: () {
                                                controller
                                                    .removeProductItem(index);
                                              },
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red))
                                        ],
                                      ),
                                    ));
                              },
                              separatorBuilder: (_, __) => const Divider(
                                  color: Color.fromARGB(244, 4, 71, 71)),
                              itemCount: controller.listOrder.length),
                        )),
                    SizedBox(
                        height: 10.h,
                        child: const Divider(
                            color: Color.fromARGB(244, 4, 71, 71))),
                    Container(
                        constraints: BoxConstraints(
                            maxHeight: 50.h,
                            minHeight: 30.h,
                            maxWidth: Get.width),
                        child: Row(
                          children: [
                            Text("Khách hàng:",
                                style: GoogleFonts.chivo(
                                  color: const Color.fromARGB(255, 2, 45, 4),
                                  fontSize: 18.sp,
                                )),
                            Expanded(
                                child: Obx(() => Text(
                                    "${controller.customer.value.first_name ?? "Khách "} ${controller.customer.value.last_name ?? "lẻ"}",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.chivo(
                                      color:
                                          const Color.fromARGB(255, 2, 45, 4),
                                      fontSize: 18.sp,
                                    )))),
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => Padding(
                                        padding: EdgeInsets.only(bottom: 30.w),
                                        // height: Get.height * 0.85,
                                        child: CustomerChoice(
                                            items: controller.listCustomer,
                                            customerChoice:
                                                controller.customer.value,
                                            onSelected: ((p0) {
                                              controller.customer.value = p0;
                                              Navigator.of(context).pop();
                                            }))),
                                  );
                                },
                                icon: Icon(Icons.search))
                          ],
                        )),
                    SizedBox(
                        height: 10.h,
                        child: const Divider(
                            color: Color.fromARGB(244, 4, 71, 71))),
                    Container(
                        constraints: BoxConstraints(
                            maxHeight: 50.h,
                            minHeight: 30.h,
                            maxWidth: Get.width),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("Tổng tiền",
                                    style: GoogleFonts.chivo(
                                      color:
                                          const Color.fromARGB(255, 2, 45, 4),
                                      fontSize: 18.sp,
                                    ))),
                            Obx(() => Text(
                                "${formatPrice(controller.total.value)} vnd",
                                style: GoogleFonts.chivo(
                                  color: const Color.fromARGB(255, 2, 45, 4),
                                  fontSize: 18.sp,
                                )))
                          ],
                        )),
                    Container(
                        constraints: BoxConstraints(
                            maxHeight: 50.h,
                            minHeight: 30.h,
                            maxWidth: Get.width),
                        child: Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(223, 4, 60, 60)),
                              onPressed: () {
                                controller.saveOrder();
                              },
                              child: const Text("THÊM ĐƠN")),
                        )),
                  ])),
        ));
  }
}
