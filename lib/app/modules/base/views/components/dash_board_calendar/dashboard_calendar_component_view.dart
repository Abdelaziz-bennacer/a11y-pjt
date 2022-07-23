import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'dashboard_calendar_component_controller.dart';

class DashBoardCalendarComponent extends StatefulWidget {
  @override
  State<DashBoardCalendarComponent> createState() => _DashBoardCalendarComponentState();
}

class _DashBoardCalendarComponentState extends State<DashBoardCalendarComponent> {
  final CalendarController _controller = CalendarController();
  final dashboardCalendarController = Get.put(DashBoardCalendarController());

  DateTime? _datePicked = DateTime.now();

  void _viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      _datePicked = viewChangedDetails
          .visibleDates[viewChangedDetails.visibleDates.length ~/ 2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    /*return FutureBuilder<List<UserTask>>(
      future: dashboardCalendarController.fetchUserTasks(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return GetBuilder<DashBoardCalendarController>(
            builder: (ctr) => SfCalendar(
              controller: _controller,
              backgroundColor: Colors.indigo.shade900,
              cellBorderColor: Colors.amber,
              headerStyle: const CalendarHeaderStyle(
                textStyle: TextStyle(color: Colors.white),
              ),
              viewHeaderStyle: const ViewHeaderStyle(
                dateTextStyle: TextStyle(color: Colors.white),
                dayTextStyle: TextStyle(color: Colors.white),
              ),
              view: CalendarView.workWeek,
              onViewChanged: _viewChanged,
              timeSlotViewSettings: const TimeSlotViewSettings(
                startHour: 6,
                endHour: 20,
                timeTextStyle: TextStyle(color: Colors.white),
              ),
              dataSource: UserCalendarDataSource(snapshot.data!),
              onTap: onCalendarTapped,
              timeZone: 'Romance Standard Time',
              allowedViews: const [
                CalendarView.day,
                CalendarView.workWeek,
                CalendarView.month,
              ],
              showWeekNumber: true,
              weekNumberStyle: const WeekNumberStyle(
                backgroundColor: Colors.amber,
                textStyle: TextStyle(color: Colors.white, fontSize: 15),
              ),
              showNavigationArrow: true,
              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                shape: BoxShape.rectangle,
              ),
              todayHighlightColor: Colors.amber,
            ),
          );
        } else {
          return Container(
            child: const Center(
              child: Text('Problème'),
            ),
          );
        }
      },
    );*/
  }
}
