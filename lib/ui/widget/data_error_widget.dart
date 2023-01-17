import 'package:choco_store_staff/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DataErrorWidget extends StatelessWidget {
  final String? messageError;
  final Function() onReloadData;

  const DataErrorWidget({
    this.messageError,
    required this.onReloadData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(
          //   DPathCore.imagesImgDataError,
          //   width: 90,
          //   height: 90,
          // ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            messageError ?? 'data.error'.tr,
            style: const TextStyle(fontWeight: FontWeight.w400)
                .copyWith(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            onPressed: () => onReloadData(),
            child: Text("Lỗi lấy dữ liệu !",
                style: GoogleFonts.prostoOne(
                    color: const Color.fromARGB(223, 4, 60, 60),
                    fontSize: 22.sp)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
            ),
          )
        ],
      ),
    );
  }
}
