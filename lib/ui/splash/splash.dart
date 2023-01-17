import 'package:choco_store_staff/app/app_pages.dart';
import 'package:choco_store_staff/ui/login/login_page.dart';
import 'package:choco_store_staff/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:chain_stores_mobile_staff/utils/dimens.dart';
// import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animationColor;

  Animation positionChange(double begin, double end) {
    return Tween<double>(begin: begin.w, end: end.w).animate(controller);
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animationColor =
        ColorTween(begin: Colors.white, end: Colors.black).animate(controller);

    animationColor.addListener(() {
      setState(() {});
    });

    controller.forward();
    changeLogin();
  }

  Future changeLogin() async {
    await Future.delayed(const Duration(seconds: 4), () {
      // Get.to(AppPages.pages, transition: Transition.zoom);
      Get.offAllNamed(AppRoutes.LOGIN);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
          child: Stack(children: [
        Positioned(
            // top: 85.w,
            top: positionChange(85, 328).value,
            left: positionChange(250, 187).value,
            // left: 250.w,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(28, 103, 88, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.storefront,
                size: 18.w,
                color: Colors.white,
              ),
            )),
        Positioned(
            // top: 230.w,
            // left: 58.w,
            top: positionChange(230, 328).value,
            left: positionChange(58, 187).value,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(28, 103, 88, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.storefront,
                size: 18.w,
                color: Colors.white,
              ),
            )),
        Positioned(
            // top: 275.w,
            // left: 313.w,
            top: positionChange(275, 328).value,
            left: positionChange(313, 187).value,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(28, 103, 88, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.storefront,
                size: 18.w,
                color: Colors.white,
              ),
            )),
        Positioned(
            // top: 452.w,
            // left: 162.w,
            top: positionChange(452, 328).value,
            left: positionChange(162, 187).value,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(28, 103, 88, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.storefront,
                size: 18.w,
                color: Colors.white,
              ),
            )),
        Positioned(
            // top: 492.w,
            // left: 324.w,
            top: positionChange(492, 328).value,
            left: positionChange(324, 187).value,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(28, 103, 88, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.storefront,
                size: 18.w,
                color: Colors.white,
              ),
            )),
        Positioned(
            // top: 529.w,
            // left: 34.w,
            top: positionChange(529, 328).value,
            left: positionChange(34, 187).value,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(28, 103, 88, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.storefront,
                size: 18.w,
                color: Colors.white,
              ),
            )),
        Positioned(
            // top: 642.w,
            // left: 226.w,
            top: positionChange(642, 328).value,
            left: positionChange(226, 187).value,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(28, 103, 88, 100),
                  borderRadius: BorderRadius.circular(38.w)),
              child: Icon(
                Icons.storefront,
                size: 18.w,
                color: Colors.white,
              ),
            )),
        Positioned(
            top: 328.w,
            left: 40.w,
            child: Container(
                padding: EdgeInsets.all(5.w),
                child: Text(
                  'CHOCO STORE',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(2.w, 2.w),
                          blurRadius: 10.0,
                          color: const Color.fromRGBO(28, 103, 88, 100),
                        ),
                        Shadow(
                          offset: Offset(-2.w, -2.w),
                          blurRadius: 1.0,
                          color: const Color.fromARGB(13, 28, 103, 88),
                        ),
                      ],
                      fontSize: 38.sp,
                      fontWeight: FontWeight.bold,
                      color: animationColor.value),
                ))),
      ]))
    ]));
  }
}
