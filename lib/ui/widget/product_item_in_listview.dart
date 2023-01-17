import 'dart:convert';

import 'package:choco_store_staff/data/api/model/reponse/sales/product_in_inventory.dart';
import 'package:choco_store_staff/utils/dimens.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:image_stack/image_stack.dart';

import '../../utils/date_time_utils.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key,
      required this.product,
      required this.viewStoreDiff,
      required this.addCard})
      : super(key: key);
  final ProductInInventory product;
  final VoidCallback viewStoreDiff;
  final VoidCallback addCard;

  @override
  Widget build(BuildContext context) {
    final List<Image> widgets = [
      ...product.product!.image!.map<Image>(
          (img) => Image.memory(base64.decode(img.src!.split(',').last)))
    ];
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          borderOnForeground: true,
          color: const Color.fromARGB(68, 15, 142, 142),
          shadowColor: const Color.fromARGB(84, 28, 103, 88),
          elevation: 5.w,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    // tapBodyToExpand: true,
                    // tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    color: const Color.fromARGB(82, 250, 243, 243),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                product.product!.name.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text("Số lượng trong kho: ${product.count}")
                            ],
                          )),
                          ExpandableIcon(
                            theme: const ExpandableThemeData(
                              expandIcon: Icons.arrow_right,
                              collapseIcon: Icons.arrow_drop_down,
                              iconColor: Colors.white,
                              iconSize: 28.0,
                              iconRotationAngle: math.pi / 2,
                              iconPadding: EdgeInsets.only(right: 5),
                              hasIcon: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Container(
                    color: const Color.fromARGB(255, 250, 243, 243),
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageStack.widgets(
                              widgetRadius: 70.w,
                              totalCount: widgets.length,
                              children: widgets,
                            ),
                            SizedBox(
                                height: 15.h,
                                child: const Divider(
                                    color: Color.fromARGB(244, 4, 71, 71))),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Giá',
                                    style: GoogleFonts.chivo(
                                        color: const Color.fromARGB(
                                            244, 4, 71, 71)),
                                  ),
                                ),
                                Text(
                                    '${formatPrice(product.product!.price!.toDouble())} vnd',
                                    style: GoogleFonts.chivo(
                                        color: const Color.fromARGB(
                                            255, 14, 60, 60)))
                              ],
                            ),
                            SizedBox(
                                height: 15.h,
                                width: Get.width - 80.w,
                                child: const Divider(
                                    color: Color.fromARGB(244, 4, 71, 71))),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Thể loại',
                                    style: GoogleFonts.chivo(
                                        color: Color.fromARGB(244, 4, 71, 71)),
                                  ),
                                ),
                                Text('${product.product!.category!.name}',
                                    style: GoogleFonts.chivo(
                                        color: const Color.fromARGB(
                                            255, 14, 60, 60)))
                              ],
                            ),
                            SizedBox(
                                height: 15.h,
                                width: Get.width - 100.w,
                                child: const Divider(
                                    color: Color.fromARGB(244, 4, 71, 71))),
                            Text(
                              'Chi tiết:',
                              style: GoogleFonts.chivo(
                                  color: const Color.fromARGB(244, 4, 71, 71)),
                            ),
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemExtent: 18.h,
                                itemCount: product.product!.detail!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: ((context, index) => SizedBox(
                                    height: 18.h,
                                    child: Text(
                                        '- ${product.product!.detail![index]}',
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.chivo(
                                            color: const Color.fromARGB(
                                                255, 14, 60, 60)))))),
                            product.count! > 0
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color.fromARGB(
                                            255, 14, 60, 60)),
                                    onPressed: () => addCard(),
                                    child: const Text("Thêm vào đơn"))
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color.fromARGB(
                                            222, 56, 5, 11)),
                                    onPressed: () => viewStoreDiff(),
                                    child: const Text("Xem ở cửa hàng khác"))
                          ],
                        )),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
