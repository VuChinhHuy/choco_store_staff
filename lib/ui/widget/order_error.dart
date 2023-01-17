import 'package:choco_store_staff/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderError extends StatelessWidget {
  const OrderError({Key? key, required this.buttonAction}) : super(key: key);
  final VoidCallback buttonAction;
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(),
        child: Card(
            elevation: 15.w,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.w))),
            semanticContainer: true,
            shadowColor: const Color.fromARGB(255, 2, 70, 58),
            color: const Color.fromARGB(255, 199, 241, 233),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 50.w),
                    child: Center(
                        child:
                            SvgPicture.asset('assets/svg/warning-error.svg'))),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Center(
                      child: Text(
                    'Lỗi',
                    style: GoogleFonts.prostoOne(
                        color: const Color.fromARGB(223, 4, 60, 60),
                        fontSize: 22.sp),
                  )),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(223, 4, 60, 60)),
                    onPressed: () {
                      buttonAction();
                    },
                    child: const Text("TRỞ VỀ")),
              ],
            )));
  }
}
