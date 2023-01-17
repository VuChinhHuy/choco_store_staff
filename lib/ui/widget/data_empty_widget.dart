import 'package:choco_store_staff/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DataEmptyWidget extends StatelessWidget {
  final Color? background;

  const DataEmptyWidget({this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: background ?? Colors.white, //getColor().backgroundWhiteBlackColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/svg/warning_error.svg",
            width: 120.w,
            height: 120.w,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Không có dữ liệu!',
            style: const TextStyle(fontWeight: FontWeight.w400)
                .copyWith(fontSize: 16.sp),
          )
        ],
      ),
    );
  }
}
