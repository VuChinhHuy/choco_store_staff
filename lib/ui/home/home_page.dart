// ignore_for_file: unnecessary_cast

import 'dart:convert';

import 'package:choco_store_staff/data/api/model/reponse/timework/calendar_work.dart';
import 'package:choco_store_staff/ui/base_page.dart';
import 'package:choco_store_staff/ui/home/home_controller.dart';
import 'package:choco_store_staff/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/date_time_utils.dart';

class HomeScreen extends BasePage<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget buildContentView(BuildContext context, HomeController controller) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        minWidth: constraints.maxWidth),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => (controller.user.value.id != null)
                            ? Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.w))),
                                color: const Color.fromARGB(133, 28, 103, 88),
                                semanticContainer: true,
                                elevation: 12.w,
                                shadowColor:
                                    const Color.fromRGBO(28, 103, 88, 100),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.all(5.w),
                                            child: CircleAvatar(
                                                radius: 64.w,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        113, 6, 85, 15),
                                                child: CircleAvatar(
                                                  radius: 60.w,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          79, 6, 85, 0),
                                                  child: controller
                                                              .user.value.avt !=
                                                          "null"
                                                      ? CircleAvatar(
                                                          radius: 56.w,
                                                          backgroundImage:
                                                              MemoryImage(
                                                                  base64.decode(
                                                                      controller
                                                                          .user
                                                                          .value
                                                                          .avt!.split(",").last)))
                                                      : CircleAvatar(
                                                          radius: 56.w,
                                                          backgroundImage:
                                                              const AssetImage(
                                                                  'assets/image/avtnone.jpeg'),
                                                        ),
                                                ))),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Text(
                                              controller.user.value.fullname!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                            if (controller
                                                    .user.value.birthday !=
                                                null)
                                              Text(
                                                formatDate(
                                                        controller.user.value
                                                            .birthday!,
                                                        DATE_FORMAT)
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                          ],
                                        )),
                                        Column(
                                          children: [
                                            IconButton(
                                                onPressed: () => {},
                                                icon: const Icon(Icons.edit)),
                                            RaisedButton(
                                              color: const Color.fromARGB(
                                                  232, 2, 59, 48),
                                              textColor: Colors.white,
                                              elevation: 10.h,
                                              child: Text(
                                                'Đăng xuất',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                                textAlign: TextAlign.center,
                                              ),
                                              onPressed: () =>
                                                  controller.logout(),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.w,
                                    ),
                                  ],
                                ))
                            : const Card(
                                child: SpinKitPouringHourGlassRefined(
                                    color: Color.fromARGB(201, 64, 171, 18)),
                              )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: buttonIconCustom(
                                    context,
                                    const Color.fromARGB(75, 33, 149, 243),
                                    const AssetImage(
                                        "assets/image/schedule.png"),
                                    const Color.fromRGBO(28, 103, 88, 100),
                                    const Color.fromARGB(79, 28, 103, 88),
                                    "Lịch làm"),
                                onTap: () => controller.toCalendarPage(),
                              ),
                              GestureDetector(
                                onTap: () => controller.toSalesPage(),
                                child: buttonIconCustom(
                                    context,
                                    const Color.fromARGB(75, 33, 149, 243),
                                    const AssetImage(
                                        "assets/image/sales-agent.png"),
                                    const Color.fromARGB(79, 28, 103, 88),
                                    const Color.fromARGB(75, 33, 149, 243),
                                    "Bán hàng"),
                              ),
                              Obx(() => GestureDetector(
                                    onTap: () {
                                      controller.isCheckin.value
                                          ? 
                                          controller.checkout(): controller.checkin();
                                      controller.calendarTimeShift1.refresh();
                                      controller.calendarTimeShift2.refresh();
                                      controller.calendarTimeShift3.refresh();
                                      // controller.refresh();
                                    },
                                    child: controller.isCheckin.value
                                        ? 
                                        buttonIconCustom(
                                            context,
                                            const Color.fromARGB(
                                                72, 54, 244, 225),
                                            const AssetImage(
                                                "assets/image/check-out.png"),
                                            const Color.fromARGB(89, 9, 73, 60),
                                            const Color.fromARGB(
                                                101, 33, 149, 243),
                                            "Check out")
                                            :buttonIconCustom(
                                            context,
                                            const Color.fromARGB(
                                                73, 244, 67, 54),
                                            const AssetImage(
                                                "assets/image/calendar.png"),
                                            const Color.fromARGB(
                                                79, 28, 103, 88),
                                            const Color.fromARGB(
                                                75, 33, 149, 243),
                                            "Check in"),
                                  ))
                            ]),
                        Obx(
                          () => controller.store.value.id != null
                              ? Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.w))),
                                  color:
                                      const Color.fromARGB(202, 217, 243, 243),
                                  semanticContainer: true,
                                  elevation: 12.w,
                                  shadowColor:
                                      const Color.fromRGBO(28, 103, 88, 100),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Get.width.w,
                                        height: 30.w,
                                        child: Card(
                                            color:
                                                Color.fromARGB(184, 2, 49, 40),
                                            semanticContainer: true,
                                            elevation: 12.w,
                                            shadowColor: const Color.fromRGBO(
                                                28, 103, 88, 100),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.w),
                                                    topRight:
                                                        Radius.circular(20.w))),
                                            child: Center(
                                              child: Text(
                                                controller
                                                    .store.value.nameStore!,
                                                style: GoogleFonts.anton(
                                                    fontSize: 16.sp,
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(10.w),
                                          child: Text(
                                            controller.store.value.address!,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.all(10.w),
                                        child: Text(
                                          "Lịch làm việc",
                                          style: GoogleFonts.oxygen(
                                            fontSize: 16.sp,
                                            color:
                                                const Color.fromARGB(255, 2, 49, 40),
                                            fontWeight: FontWeight.bold,
                                            backgroundColor: const  Color.fromARGB(
                                                189, 225, 241, 238),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      controller.timework.value.id != null
                                          ? ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  // minHeight:
                                                  //     constraints.minHeight,
                                                  minWidth:
                                                      constraints.maxWidth),
                                              child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        width: 130.w,
                                                        child:
                                                            ListView.separated(
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return SizedBox(
                                                                    height:
                                                                        66.h,
                                                                    child: GestureDetector(
                                                                        onTap: () {},
                                                                        child: Card(
                                                                            color: const Color.fromARGB(50, 105, 222, 175),
                                                                            shadowColor: const Color.fromARGB(50, 105, 222, 175),
                                                                            semanticContainer: true,
                                                                            elevation: 10.w,
                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.w))),
                                                                            // shadowColor: const Color.fromRGBO(28, 103, 88, 100),
                                                                            child: Center(
                                                                                child: Column(
                                                                              children: [
                                                                                Text(
                                                                                  index > 0 ? controller.timework.value.timeShift![index - 1].name.toString() : "",
                                                                                  style: TextStyle(color: Color.fromARGB(237, 4, 86, 71), fontSize: 14.sp, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                index > 0
                                                                                    ? Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Chip(
                                                                                              label: Text('${formatDecimalTime(controller.timework.value.timeShift![index - 1].timeStart!.hour! as int)}:${formatDecimalTime(controller.timework.value.timeShift![index - 1].timeStart!.minute! as int)}'),
                                                                                              backgroundColor: Color.fromARGB(99, 11, 92, 92),
                                                                                            ),
                                                                                          ),
                                                                                          const Text(
                                                                                            "-",
                                                                                            style: TextStyle(color: Color.fromARGB(99, 11, 92, 92)),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Chip(
                                                                                            label: Text('${formatDecimalTime(controller.timework.value.timeShift![index - 1].timeEnd!.hour! as int)}:${formatDecimalTime(controller.timework.value.timeShift![index - 1].timeEnd!.minute! as int)}'),
                                                                                            backgroundColor: Color.fromARGB(99, 11, 92, 92),
                                                                                          )),
                                                                                        ],
                                                                                      )
                                                                                    : SizedBox()
                                                                              ],
                                                                            )))),
                                                                  );
                                                                },
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 1
                                                                            .w),
                                                                separatorBuilder:
                                                                    (_, __) =>
                                                                        const SizedBox(),
                                                                itemCount: controller
                                                                        .timework
                                                                        .value
                                                                        .timeShift!
                                                                        .length +
                                                                    1)),
                                                    Expanded(
                                                        child: Container(
                                                            constraints: BoxConstraints(
                                                                minHeight: 100
                                                                    .h,
                                                                minWidth:
                                                                    constraints
                                                                        .minWidth,
                                                                maxHeight: 268
                                                                    .h,
                                                                maxWidth:
                                                                    constraints
                                                                        .maxWidth),
                                                            child: ListView
                                                                .separated(
                                                                    itemBuilder:
                                                                        (context,
                                                                            i) {
                                                                      return Container(
                                                                          constraints: BoxConstraints(
                                                                              minHeight: 100.h,
                                                                              minWidth: 100.w,
                                                                              maxHeight: 300.h,
                                                                              maxWidth: 200.w),
                                                                          child: controller.timework.value.timeShift!.length == 2
                                                                              ? Column(
                                                                                  children: [
                                                                                    Container(
                                                                                        height: 66.h,
                                                                                        width: 100.w,
                                                                                        child: Card(
                                                                                          color: Color.fromARGB(232, 2, 59, 48),
                                                                                          shadowColor: const Color.fromARGB(50, 105, 222, 175),
                                                                                          semanticContainer: true,
                                                                                          elevation: 10.w,
                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.w))),
                                                                                          // shadowColor: const Color.fromRGBO(28, 103, 88, 100),

                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              formatDayofWeek(controller.dayOfNextWeek[i]),
                                                                                              style: Theme.of(context).textTheme.subtitle2,
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          ),
                                                                                        )),
                                                                                    Container(
                                                                                        height: 66.h,
                                                                                        width: 200.w,
                                                                                        child: Card(
                                                                                            color: Color.fromARGB(147, 115, 234, 167),
                                                                                            shadowColor: const Color.fromARGB(50, 105, 222, 175),
                                                                                            semanticContainer: true,
                                                                                            elevation: 10.w,
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.w))),
                                                                                            child: Obx(() => controller.calendarTimeShift1.isNotEmpty
                                                                                                ? Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                    SizedBox(height: 50.h, width: 50.w, child: CircleAvatar(radius: 56.w, backgroundImage: const AssetImage('assets/image/avtnone.jpeg'))),
                                                                                                    Expanded(
                                                                                                        child: Obx(() => Column(
                                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  controller.calendarTimeShift1[i].timeShift!.isNotEmpty ? controller.calendarTimeShift1[i].timeShift![0].staff!.fullname! : "",
                                                                                                                  style: GoogleFonts.acme(color: Colors.white, fontSize: 12.sp),
                                                                                                                ),
                                                                                                              ],
                                                                                                            )))
                                                                                                  ])
                                                                                                : const SizedBox.shrink()))),
                                                                                    Container(
                                                                                        height: 66.h,
                                                                                        width: 200.w,
                                                                                        child: Card(
                                                                                            color: Color.fromARGB(147, 115, 234, 167),
                                                                                            shadowColor: const Color.fromARGB(50, 105, 222, 175),
                                                                                            semanticContainer: true,
                                                                                            elevation: 10.w,
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.w))),
                                                                                            child: Obx(() => controller.calendarTimeShift2.isNotEmpty
                                                                                                ? Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                    SizedBox(height: 50.h, width: 50.w, child: CircleAvatar(radius: 56.w, backgroundImage: const AssetImage('assets/image/avtnone.jpeg'))),
                                                                                                    Expanded(
                                                                                                        child: Obx(() => Column(
                                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  controller.calendarTimeShift2[i].timeShift!.isNotEmpty ? controller.calendarTimeShift2[i].timeShift![0].staff!.fullname! : "",
                                                                                                                  style: GoogleFonts.acme(color: Colors.white, fontSize: 12.sp),
                                                                                                                ),
                                                                                                              ],
                                                                                                            )))
                                                                                                  ])
                                                                                                : const SizedBox.shrink()))),
                                                                                  ],
                                                                                )
                                                                              : Column(
                                                                                  children: [
                                                                                    Container(
                                                                                        height: 66.h,
                                                                                        width: 200.w,
                                                                                        child: Card(
                                                                                          color: Color.fromARGB(232, 2, 59, 48),
                                                                                          shadowColor: const Color.fromARGB(50, 105, 222, 175),
                                                                                          semanticContainer: true,
                                                                                          elevation: 10.w,
                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.w))),
                                                                                          // shadowColor: const Color.fromRGBO(28, 103, 88, 100),

                                                                                          child: Center(
                                                                                              child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text(
                                                                                                formatDayofWeek(controller.dayOfNextWeek[i]),
                                                                                                style: Theme.of(context).textTheme.subtitle2,
                                                                                                textAlign: TextAlign.center,
                                                                                              ),
                                                                                              Text(
                                                                                                formatDate(controller.dayOfNextWeek[i], DATE_FORMAT).toString(),
                                                                                                style: TextStyle(color: Colors.white),
                                                                                              )
                                                                                            ],
                                                                                          )),
                                                                                        )),
                                                                                    Container(
                                                                                        height: 66.h,
                                                                                        width: 200.w,
                                                                                        child: Card(
                                                                                            color: Color.fromARGB(147, 115, 234, 167),
                                                                                            shadowColor: const Color.fromARGB(50, 105, 222, 175),
                                                                                            semanticContainer: true,
                                                                                            elevation: 10.w,
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.w))),
                                                                                            child: Obx(() => (controller.calendarTimeShift1.isNotEmpty)
                                                                                                ? controller.calendarTimeShift1[i].timeShift!.isNotEmpty
                                                                                                    ? Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                        SizedBox(height: 50.h, width: 50.w, child: CircleAvatar(radius: 56.w, backgroundImage: const AssetImage('assets/image/avtnone.jpeg'))),
                                                                                                        Expanded(
                                                                                                            child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              controller.calendarTimeShift1[i].timeShift![0].staff!.fullname!,
                                                                                                              style: GoogleFonts.lato(color: const Color.fromARGB(255, 2, 45, 4), fontSize: 14.sp),
                                                                                                            ),
                                                                                                            Row(
                                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Chip(
                                                                                                                  label: controller.calendarTimeShift1[i].timeShift![0].checkStart != null ? Text("${formatDecimalTime(controller.calendarTimeShift1[i].timeShift![0].checkStart!.hour!)}:${formatDecimalTime(controller.calendarTimeShift1[i].timeShift![0].checkStart!.minute!)}") : Text("Check in"),
                                                                                                                  labelStyle: GoogleFonts.acme(color: const  Color.fromARGB(255, 2, 45, 4), fontSize: 12.sp),
                                                                                                                
                                                                                                                ),
                                                                                                                Chip(
                                                                                                                  label: controller.calendarTimeShift1[i].timeShift![0].checkEnd != null ? Text("${formatDecimalTime(controller.calendarTimeShift1[i].timeShift![0].checkEnd!.hour!)}:${formatDecimalTime(controller.calendarTimeShift1[i].timeShift![0].checkEnd!.minute!)}") : Text("Check out"),
                                                                                                                  labelStyle: GoogleFonts.acme(color:const Color.fromARGB(255, 2, 45, 4), fontSize: 12.sp),
                                                                                                                )
                                                                                                              ],
                                                                                                            )
                                                                                                          ],
                                                                                                        ))
                                                                                                      ])
                                                                                                    : const SizedBox.shrink()
                                                                                                : const SizedBox.shrink()))),
                                                                                    Container(
                                                                                        height: 66.h,
                                                                                        width: 200.w,
                                                                                        child: Card(
                                                                                            color: Color.fromARGB(147, 115, 234, 167),
                                                                                            shadowColor: const Color.fromARGB(50, 105, 222, 175),
                                                                                            semanticContainer: true,
                                                                                            elevation: 10.w,
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.w))),
                                                                                            child: Obx(() => (controller.calendarTimeShift2.isNotEmpty)
                                                                                                ? controller.calendarTimeShift2[i].timeShift!.isNotEmpty
                                                                                                    ? Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                        SizedBox(height: 50.h, width: 50.w, child: CircleAvatar(radius: 56.w, backgroundImage: const AssetImage('assets/image/avtnone.jpeg'))),
                                                                                                        Expanded(
                                                                                                            child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              controller.calendarTimeShift2[i].timeShift![0].staff!.fullname!,
                                                                                                              style: GoogleFonts.lato(color: const Color.fromARGB(255, 2, 45, 4), fontSize: 14.sp),
                                                                                                            ),
                                                                                                            Row(
                                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Chip(
                                                                                                                  label: controller.calendarTimeShift2[i].timeShift![0].checkStart != null ? Text("${formatDecimalTime(controller.calendarTimeShift2[i].timeShift![0].checkStart!.hour!)}:${formatDecimalTime(controller.calendarTimeShift2[i].timeShift![0].checkStart!.minute!)}") : Text("Check in"),
                                                                                                                  labelStyle: GoogleFonts.acme(color: const  Color.fromARGB(255, 2, 45, 4), fontSize: 12.sp),
                                                                                                                
                                                                                                                ),
                                                                                                                Chip(
                                                                                                                  label: controller.calendarTimeShift2[i].timeShift![0].checkEnd != null ? Text("${formatDecimalTime(controller.calendarTimeShift2[i].timeShift![0].checkEnd!.hour!)}:${formatDecimalTime(controller.calendarTimeShift2[i].timeShift![0].checkEnd!.minute!)}") : Text("Check out"),
                                                                                                                  labelStyle: GoogleFonts.acme(color:const Color.fromARGB(255, 2, 45, 4), fontSize: 12.sp),
                                                                                                                )
                                                                                                              ],
                                                                                                            )
                                                                                                          ],
                                                                                                        ))
                                                                                                      ])
                                                                                                    : const SizedBox.shrink()
                                                                                                : const SizedBox.shrink()))),
                                                                                    Container(
                                                                                        height: 66.h,
                                                                                        width: 200.w,
                                                                                        child: Card(
                                                                                            color: Color.fromARGB(147, 115, 234, 167),
                                                                                            shadowColor: const Color.fromARGB(50, 105, 222, 175),
                                                                                            semanticContainer: true,
                                                                                            elevation: 10.w,
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.w))),
                                                                                            child: Obx(() => (controller.calendarTimeShift3.isNotEmpty)
                                                                                                ? controller.calendarTimeShift3[i].timeShift!.isNotEmpty
                                                                                                    ? Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                        SizedBox(height: 50.h, width: 50.w, child: CircleAvatar(radius: 56.w, backgroundImage: const AssetImage('assets/image/avtnone.jpeg'))),
                                                                                                        Expanded(
                                                                                                            child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              controller.calendarTimeShift3[i].timeShift![0].staff!.fullname!,
                                                                                                              style: GoogleFonts.lato(color: const Color.fromARGB(255, 2, 45, 4), fontSize: 14.sp),
                                                                                                            ),
                                                                                                            Row(
                                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Chip(
                                                                                                                  label: controller.calendarTimeShift3[i].timeShift![0].checkStart != null ? Text("${formatDecimalTime(controller.calendarTimeShift3[i].timeShift![0].checkStart!.hour!)}:${formatDecimalTime(controller.calendarTimeShift3[i].timeShift![0].checkStart!.minute!)}") : Text("Check in"),
                                                                                                                  labelStyle: GoogleFonts.acme(color: const  Color.fromARGB(255, 2, 45, 4), fontSize: 12.sp),
                                                                                                                
                                                                                                                ),
                                                                                                                Chip(
                                                                                                                  label: controller.calendarTimeShift3[i].timeShift![0].checkEnd != null ? Text("${formatDecimalTime(controller.calendarTimeShift3[i].timeShift![0].checkEnd!.hour!)}:${formatDecimalTime(controller.calendarTimeShift3[i].timeShift![0].checkEnd!.minute!)}") : Text("Check out"),
                                                                                                                  labelStyle: GoogleFonts.acme(color:const Color.fromARGB(255, 2, 45, 4), fontSize: 12.sp),
                                                                                                                )
                                                                                                              ],
                                                                                                            )
                                                                                                          ],
                                                                                                        ))
                                                                                                      ])
                                                                                                    : const SizedBox.shrink()
                                                                                                : const SizedBox.shrink()))),
                                                                                  ],
                                                                                ));
                                                                    },
                                                                    scrollDirection: Axis
                                                                        .horizontal,
                                                                    shrinkWrap:
                                                                        true,
                                                                    padding: EdgeInsets.only(
                                                                        top: 1
                                                                            .w),
                                                                    separatorBuilder:
                                                                        (_, __) =>
                                                                            const SizedBox(),
                                                                    itemCount: controller
                                                                        .dayOfNextWeek
                                                                        .length)))
                                                  ]))
                                          : const Card()
                                    ],
                                  ))
                              : const Card(
                                  // child: SpinKitPouringHourGlassRefined(
                                  //     duration: Duration(minutes: 10),
                                  //     color: Color.fromARGB(201, 64, 171, 18)),
                                  ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    )))));
  }

  Widget buttonIconCustom(
      BuildContext context,
      Color color,
      ImageProvider image,
      Color backgroundImage,
      Color backgroundColorCircle,
      String title) {
    return Column(
      children: [
        Container(
            height: 72.w,
            width: 72.w,
            child: Card(
                semanticContainer: true,
                elevation: 10.w,
                color: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.w))),
                shadowColor: const Color.fromRGBO(28, 103, 88, 100),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: CircleAvatar(
                      backgroundColor:
                          backgroundColorCircle, //color background,
                      child: CircleAvatar(
                        radius: 24.w,
                        backgroundColor: backgroundImage,
                        backgroundImage: image,
                      )),
                ))),
        SizedBox(
          height: 5.w,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }
}
