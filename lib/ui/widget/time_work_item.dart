// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:choco_store_staff/data/api/model/reponse/timework/time_shift.dart';
import 'package:choco_store_staff/utils/dimens.dart';

import '../../utils/date_time_utils.dart';
import '../../utils/logger_debug/flutter_logger.dart';

class TimeWorkItem extends StatefulWidget {
  const TimeWorkItem({
    Key? key,
    required this.timeShift,
    required this.onTimeShiftSelected,
    required this.isTrue,
  }) : super(key: key);
  final TimeShift timeShift;
  final VoidCallback onTimeShiftSelected;
  final RxBool isTrue;
  @override
  State<StatefulWidget> createState() => _TimeWorkItemState();
}

class _TimeWorkItemState extends State<TimeWorkItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Card(
        borderOnForeground: true,
        color: Color.fromARGB(68, 15, 142, 142),
        shadowColor: Color.fromARGB(245, 28, 103, 88),
        elevation: 5.w,
        margin: EdgeInsets.all(5.w),
        child: Column(
          children: [
            Container(
                constraints: BoxConstraints(
                    minHeight: 50.h, maxHeight: 100.h, minWidth: Get.width),
                child: Card(
                  semanticContainer: true,
                  shadowColor: Color.fromARGB(245, 28, 103, 88),
                  elevation: 5.w,
                  margin: EdgeInsets.only(
                    bottom: 5.w,
                  ),
                  color: Color.fromARGB(237, 5, 93, 118),
                  child: Padding(
                      padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                      child: Text(
                        widget.timeShift.name!,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      )),
                )),
            Row(
              children: [
                Expanded(
                  child: Chip(
                    label: Text(
                        '${formatDecimalTime(widget.timeShift.timeStart!.hour as int)}:${formatDecimalTime(widget.timeShift.timeStart!.minute as int)}'),
                    backgroundColor: Color.fromARGB(8, 11, 92, 92),
                  ),
                ),
                const Text(
                  "-",
                  style: TextStyle(color: Color.fromARGB(255, 253, 250, 250)),
                ),
                Expanded(
                    child: Chip(
                  label: Text(
                      '${formatDecimalTime(widget.timeShift.timeEnd!.hour as int)}:${formatDecimalTime(widget.timeShift.timeEnd!.minute as int)}'),
                  backgroundColor: Color.fromARGB(3, 11, 92, 92),
                )),
                Container(
                  constraints: BoxConstraints(
                      minHeight: 50.h, maxHeight: 100.h, minWidth: 200.w),
                  color: Color.fromARGB(255, 214, 234, 191),
                  child: Checkbox(
                    onChanged: (value) {
                      setState(() {
                        widget.onTimeShiftSelected();
                        widget.isTrue.value = value!;
                      });
                    },
                    value: widget.isTrue.value,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
