import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:choco_store_staff/data/api/model/reponse/customer/customer.dart';
import 'package:choco_store_staff/utils/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerChoice extends StatefulWidget {
  const CustomerChoice(
      {Key? key,
      required this.items,
      required this.onSelected,
      required this.customerChoice})
      : super(key: key);

  final List<CustomerModel> items;
  final Function(CustomerModel) onSelected;
  final CustomerModel customerChoice;
  @override
  State<StatefulWidget> createState() => _CustomerChoice();
}

class _CustomerChoice extends State<CustomerChoice> {
  EdgeInsets get padding =>
      const EdgeInsets.symmetric(horizontal: 0, vertical: 15);

  double get itemSpacing => 0;

  Color get dividerColor => Colors.white;

  Color get background => Colors.white;

  ScrollController scrollController = ScrollController();

  late CustomerModel groupChoice = widget.customerChoice;

  late List<CustomerModel> list = widget.items;

  TextEditingController textSearch = TextEditingController();
  @override
  void initState() {
    super.initState();
    textSearch.addListener(_textSearchChange);
    groupChoice = widget.customerChoice;
  }

  _textSearchChange() {
    setState(() {
      if (textSearch.text.isEmpty || textSearch.value == "") {
        list = widget.items;
      } else {
        var listSearch = widget.items
            .where((x) =>
                x.first_name
                    .toString()
                    .toLowerCase()
                    .contains(textSearch.text.toLowerCase()) ||
                x.last_name
                    .toString()
                    .toLowerCase()
                    .contains(textSearch.text.toLowerCase()))
            .toList();
        list = listSearch;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
            child: AnimSearchBar(
              textController: textSearch,
              width: Get.width,
              // closeSearchOnSuffixTap: true,
              color: const Color.fromRGBO(28, 103, 88, 100),
              style: GoogleFonts.acme(
                  color: const Color.fromARGB(255, 213, 238, 214),
                  fontSize: 18.sp),
              rtl: true,
              autoFocus: false,
              onSuffixTap: () {
                textSearch.clear();
              },
            ),
          ),
        ),
        SliverPadding(
          padding: padding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            groupChoice = list[index];
                            widget.onSelected(list[index]);
                          });
                        },
                        child: Card(
                            elevation: 15.w,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.w))),
                            semanticContainer: true,
                            color: const Color.fromRGBO(227, 235, 247, 1),
                            child: Row(
                              children: [
                                Radio<CustomerModel>(
                                  value: list[index],
                                  groupValue: groupChoice,
                                  onChanged: (CustomerModel? value) {
                                    setState(() {
                                      groupChoice = list[index];
                                      widget.onSelected(list[index]);
                                    });
                                  },
                                ),
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.w, horizontal: 10.w),
                                        child: Text(
                                            (list[index].first_name != null &&
                                                    list[index].last_name !=
                                                        null)
                                                ? "${list[index].first_name} ${list[index].last_name}"
                                                : "Khách lẻ",
                                            style: GoogleFonts.unicaOne(
                                                color: const Color.fromARGB(
                                                    255, 2, 45, 4),
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.bold)))),
                              ],
                            ))),
                    Divider(height: itemSpacing, color: dividerColor)
                  ],
                );
              },
              childCount: list.length,
            ),
          ),
        ),
      ],
    );
  }
}
