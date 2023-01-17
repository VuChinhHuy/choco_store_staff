
import 'package:choco_store_staff/data/api/model/reponse/timework/register_work_ui.dart';
import 'package:choco_store_staff/ui/base_page.dart';
import 'package:choco_store_staff/ui/register_calendar/register_calendar_controller.dart';
import 'package:choco_store_staff/ui/widget/time_work_item.dart';
import 'package:choco_store_staff/utils/dimens.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../utils/date_time_utils.dart';
import '../../utils/logger_debug/flutter_logger.dart';

class RegisterCalendarPage extends BasePage<RegisterCalendarController> {
  const RegisterCalendarPage({Key? key}) : super(key: key);

  @override
  Widget buildContentView(
      BuildContext context, RegisterCalendarController controller) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
            child: Row(
          children: [
            const BackButton(),
            Expanded(
                child: Text(
              'Đăng kí lịch làm việc theo tuần',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ))
          ],
        )),
        Container(
          constraints: BoxConstraints(
            maxHeight: 420.h,
            minHeight: 200.h,
          ),
          child: Column(
            children: [
              Container(
                  height: 50.w,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Obx(() => Container(
                          width: 50.w,
                          color: const Color.fromARGB(50, 105, 222, 175),
                          child: GestureDetector(
                            onTap: () {
                              controller.dateSelected.value = index;
                            },
                            child: Card(
                                color: controller.dateSelected.value == index
                                    ? const Color.fromRGBO(28, 103, 88, 100)
                                    : const Color.fromARGB(50, 105, 222, 175),
                                shadowColor: controller.dateSelected.value ==
                                        index
                                    ? const Color.fromRGBO(28, 103, 88, 100)
                                    : const Color.fromARGB(50, 105, 222, 175),
                                semanticContainer: true,
                                elevation: 10.w,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.w))),
                                // shadowColor: const Color.fromRGBO(28, 103, 88, 100),
                                child: Center(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          formatDayofWeek(controller
                                              .dayOfNextWeek.value[index]),
                                          style:
                                              controller.dateSelected.value ==
                                                      index
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .subtitle2
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                        ),
                                        Text(
                                          '${controller.dayOfNextWeek.value[index].day}/${controller.dayOfNextWeek.value[index].month}',
                                          style:
                                              controller.dateSelected.value ==
                                                      index
                                                  ? const TextStyle(
                                                      color: Colors.white)
                                                  : const TextStyle(
                                                      color: Colors.black),
                                        )
                                      ]),
                                )),
                          )));
                    },
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => const SizedBox(),
                    itemCount: controller.dayOfNextWeek.value.length,
                  )),
              Obx(() => controller.registerworkUI.value.isNotEmpty
                  ? Container(
                      constraints: BoxConstraints(
                        maxHeight: 350.h,
                        minHeight: 200.h,
                      ),
                      child: Obx(
                        () {
                          List<TimeShiftChose>? listTimeShift = controller
                              .registerworkUI
                              .value[controller.dateSelected.value]
                              .timeShiftChose;
                          return ListView.separated(
                              itemBuilder: (context, index) => Obx(() =>
                                  TimeWorkItem(
                                    timeShift: listTimeShift![index].timeShift!,
                                    onTimeShiftSelected: () {
                                      controller
                                              .registerworkUI
                                              .value[controller.dateSelected.value]
                                              .timeShiftChose![index]
                                              .chose =
                                          !controller
                                              .registerworkUI
                                              .value[
                                                  controller.dateSelected.value]
                                              .timeShiftChose![index]
                                              .chose;
                                      controller.update();
                                      controller.registerworkUI.refresh();
                                    },
                                    isTrue: controller
                                        .registerworkUI
                                        .value[controller.dateSelected.value]
                                        .timeShiftChose![index]
                                        .chose
                                        .obs,
                                  )),
                              separatorBuilder: (_, __) => const SizedBox(),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listTimeShift!.length);
                        },
                      ))
                  : const SizedBox())
            ],
          ),
        ),
        controller.timework.value.id != null
            ? Obx(() => ConstrainedBox(
                constraints: BoxConstraints(
                    // minHeight:
                    //     constraints.minHeight,
                    minWidth: Get.width),
                child: Card(
                  color: Color.fromARGB(130, 192, 240, 221),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 68.w,
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: 50.h,
                                    child: GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                            color: const Color.fromARGB(
                                                50, 105, 222, 175),
                                            shadowColor: const Color.fromARGB(
                                                50, 105, 222, 175),
                                            semanticContainer: true,
                                            elevation: 10.w,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.w))),
                                            // shadowColor: const Color.fromRGBO(28, 103, 88, 100),
                                            child: Center(
                                              child: Text(
                                                index > 0
                                                    ? controller
                                                        .timework
                                                        .value
                                                        .timeShift![index - 1]
                                                        .name
                                                        .toString()
                                                    : "",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        237, 4, 86, 71),
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ))),
                                  );
                                },
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 1.w),
                                separatorBuilder: (_, __) => const SizedBox(),
                                itemCount: controller
                                        .timework.value.timeShift!.length +
                                    1)),
                        Expanded(
                            child: Container(
                                constraints: BoxConstraints(
                                    minHeight: 100.h,
                                    minWidth: Get.width,
                                    maxHeight: 220.h,
                                    maxWidth: Get.width),
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Container(
                                          constraints: BoxConstraints(
                                              minHeight: 100.h,
                                              minWidth: 50.w,
                                              maxHeight: 268.h,
                                              maxWidth: 100.w),
                                          child:
                                              controller.timework.value
                                                          .timeShift!.length ==
                                                      2
                                                  ? Column(
                                                      children: [
                                                        Container(
                                                            height: 50.h,
                                                            width: 50.w,
                                                            child: Card(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  232,
                                                                  2,
                                                                  59,
                                                                  48),
                                                              shadowColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      50,
                                                                      105,
                                                                      222,
                                                                      175),
                                                              semanticContainer:
                                                                  true,
                                                              elevation: 10.w,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              12.w))),
                                                              // shadowColor: const Color.fromRGBO(28, 103, 88, 100),

                                                              child: Center(
                                                                child: Text(
                                                                  formatDayofWeek(
                                                                      controller
                                                                              .dayOfNextWeek[
                                                                          index]),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle2,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            )),
                                                        Obx(() => Container(
                                                            height: 50.h,
                                                            width: 50.w,
                                                            child: Card(
                                                              color: controller
                                                                      .registerworkUI
                                                                      .value[
                                                                          index]
                                                                      .timeShiftChose![
                                                                          0]
                                                                      .chose
                                                                  ? Color
                                                                      .fromARGB(
                                                                          210,
                                                                          161,
                                                                          128,
                                                                          19)
                                                                  : const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      103,
                                                                      88,
                                                                      100),
                                                              shadowColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      50,
                                                                      105,
                                                                      222,
                                                                      175),
                                                              semanticContainer:
                                                                  true,
                                                              elevation: 10.w,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              12.w))),
                                                            ))),
                                                        Container(
                                                            height: 50.h,
                                                            width: 50.w,
                                                            child:
                                                                Obx(() => Card(
                                                                      color: controller
                                                                              .registerworkUI
                                                                              .value[
                                                                                  index]
                                                                              .timeShiftChose![
                                                                                  1]
                                                                              .chose
                                                                          ? Color.fromARGB(
                                                                              210,
                                                                              161,
                                                                              128,
                                                                              19)
                                                                          : const Color.fromRGBO(
                                                                              28,
                                                                              103,
                                                                              88,
                                                                              100),
                                                                      shadowColor: const Color
                                                                              .fromARGB(
                                                                          50,
                                                                          105,
                                                                          222,
                                                                          175),
                                                                      semanticContainer:
                                                                          true,
                                                                      elevation:
                                                                          10.w,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(12.w))),
                                                                    ))),
                                                      ],
                                                    )
                                                  : Obx(() => Column(
                                                        children: [
                                                          Container(
                                                              height: 50.h,
                                                              width: 50.w,
                                                              child: Card(
                                                                color: Color
                                                                    .fromARGB(
                                                                        232,
                                                                        2,
                                                                        59,
                                                                        48),
                                                                shadowColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        50,
                                                                        105,
                                                                        222,
                                                                        175),
                                                                semanticContainer:
                                                                    true,
                                                                elevation: 10.w,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(12.w))),
                                                                // shadowColor: const Color.fromRGBO(28, 103, 88, 100),

                                                                child: Center(
                                                                  child: Text(
                                                                    formatDayofWeek(
                                                                        controller
                                                                            .dayOfNextWeek[index]),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .subtitle2,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              )),
                                                          Container(
                                                            height: 50.h,
                                                            width: 50.w,
                                                            child: Obx(() {
                                                              Color color = controller
                                                                      .registerworkUI
                                                                      .value[
                                                                          index]
                                                                      .timeShiftChose![
                                                                          0]
                                                                      .chose
                                                                  ? const Color
                                                                          .fromARGB(
                                                                      210,
                                                                      161,
                                                                      128,
                                                                      19)
                                                                  : const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      103,
                                                                      88,
                                                                      100);
                                                              return Card(
                                                                color: color,
                                                                shadowColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        50,
                                                                        105,
                                                                        222,
                                                                        175),
                                                                semanticContainer:
                                                                    true,
                                                                elevation: 10.w,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(12.w))),
                                                              );
                                                            }),
                                                          ),
                                                          Container(
                                                            height: 50.h,
                                                            width: 50.w,
                                                            child: Obx(() {
                                                              Color color = controller
                                                                      .registerworkUI
                                                                      .value[
                                                                          index]
                                                                      .timeShiftChose![
                                                                          1]
                                                                      .chose
                                                                  ? const Color
                                                                          .fromARGB(
                                                                      210,
                                                                      161,
                                                                      128,
                                                                      19)
                                                                  : const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      103,
                                                                      88,
                                                                      100);
                                                              return Card(
                                                                color: color,
                                                                shadowColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        50,
                                                                        105,
                                                                        222,
                                                                        175),
                                                                semanticContainer:
                                                                    true,
                                                                elevation: 10.w,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(12.w))),
                                                              );
                                                            }),
                                                          ),
                                                          Container(
                                                            height: 50.h,
                                                            width: 50.w,
                                                            child: Obx(() {
                                                              Color color = controller
                                                                      .registerworkUI
                                                                      .value[
                                                                          index]
                                                                      .timeShiftChose![
                                                                          2]
                                                                      .chose
                                                                  ? const Color
                                                                          .fromARGB(
                                                                      210,
                                                                      161,
                                                                      128,
                                                                      19)
                                                                  : const Color
                                                                          .fromRGBO(
                                                                      28,
                                                                      103,
                                                                      88,
                                                                      100);
                                                              return Card(
                                                                color: color,
                                                                shadowColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        50,
                                                                        105,
                                                                        222,
                                                                        175),
                                                                semanticContainer:
                                                                    true,
                                                                elevation: 10.w,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(12.w))),
                                                              );
                                                            }),
                                                          ),
                                                        ],
                                                      )));
                                    },
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 1.w),
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(),
                                    itemCount:
                                        controller.dayOfNextWeek.length)))
                      ]),
                )))
            : const Card(),
        Container(
          constraints: BoxConstraints(maxHeight: 50.h, minWidth: Get.width),
          color: const Color.fromRGBO(28, 103, 88, 100),
          child: TextButton(
              child: Text(
                "Xác nhận đăng kí",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: (() {
                controller.saveRegisterCalendar();
              })),
        )
      ],
    ));
  }
}
