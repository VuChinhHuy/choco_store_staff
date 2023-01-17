import 'package:choco_store_staff/utils/dimens.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSaveNoPayList extends StatelessWidget {
  const OrderSaveNoPayList(
      {Key? key,
      required this.items,
      required this.deletedItem,
      required this.choseItem})
      : super(key: key);
  final List<dynamic> items;
  final Function(int) deletedItem;
  final Function(Map) choseItem;

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
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
                Text("Không có hoá đơn",
                    style: GoogleFonts.prostoOne(
                        color: const Color.fromARGB(223, 4, 60, 60),
                        fontSize: 22.sp)),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 50.h),
                    child: Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(223, 4, 60, 60)),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("TRỞ VỀ")),
                    )),
              ],
            ),
          )
        : Container(
            height: 500.h,
            width: 300.w,
            child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      choseItem(items[index]);
                    },
                    child: Slidable(
                      // ignore: sort_child_properties_last
                      child: ExpandableNotifier(
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
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      // tapBodyToExpand: true,
                                      // tapBodyToCollapse: true,
                                      tapHeaderToExpand: false,
                                      hasIcon: true,
                                    ),
                                    header: Container(
                                      color: const Color.fromARGB(
                                          82, 250, 243, 243),
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                              child: Text("${index + 1}"))),
                                    ),
                                    collapsed: Container(),
                                    expanded: Container(
                                      color: const Color.fromARGB(
                                          255, 250, 243, 243),
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, i) => Text(
                                                  '${items[index]['order'][i]['product']['name']}'),
                                              separatorBuilder: (_, __) =>
                                                  Divider(
                                                    height: 2.h,
                                                    color: Colors.black,
                                                  ),
                                              itemCount: items[index]['order']
                                                  .length)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )),

                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 2,
                            onPressed: (context) => deletedItem(index),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Xoá',
                          ),
                          // SlidableAction(
                          //   // An action can be bigger than the others.
                          //   flex: 2,
                          //   onPressed: doNothing,
                          //   backgroundColor: Colors.red,
                          //   foregroundColor: Colors.white,
                          //   icon: Icons.arrow_forward,
                          //   label: 'Tiếp tục',
                          // ),
                        ],
                      ),
                    )),
                separatorBuilder: (_, __) => const SizedBox.shrink(),
                itemCount: items.length));
  }
}
