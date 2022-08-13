import 'package:a11y_pjt/app/modules/base/controllers/dashboard_calendar_component_controller.dart';
import 'package:a11y_pjt/app/routes/app_pages.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../base/views/components/dash_board_calendar/usertask_subject_picker.dart';
import '../controllers/admin_calendar_controller.dart';

class ManagerCalendar extends StatefulWidget {
  const ManagerCalendar({Key? key}) : super(key: key);

  @override
  State<ManagerCalendar> createState() => _ManagerCalendarState();
}

class _ManagerCalendarState extends State<ManagerCalendar> {
  final managerCalendarController = Get.find<AdminCalendarController>();
  final CalendarController _controller = CalendarController();
  final dashboardCalendarController = Get.find<DashBoardCalendarController>();

  DateTime? _datePicked = DateTime.now();

  void _viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      _datePicked = viewChangedDetails
          .visibleDates[viewChangedDetails.visibleDates.length ~/ 2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.offAndToNamed(AppPages.BASE),
            icon: Icon(Icons.chevron_left),
        ),
        title: Text('Utilisateurs', style: GoogleFonts.acme(),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<AdminCalendarController>(builder: (logic) {
            return Expanded(
              flex: 1,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    //maxWidth: MediaQuery.of(context).size.width * 0.99,
                    maxHeight: MediaQuery
                        .of(context)
                        .size
                        .height * 0.92,
                  ),
                  child: FutureBuilder<List<TasksForManagerCalendar>>(
                    future: managerCalendarController.fetchManagerTasks(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return SfCalendar(
                          resourceViewHeaderBuilder: resourceBuilder,
                          //resourceViewSettings: const ResourceViewSettings(),
                          controller: _controller,
                          onViewChanged: _viewChanged,
                          dataSource: ManagerCalendarDataSource(snapshot.data!,
                              managerCalendarController.employeesResourceList),
                          onTap: onCalendarTapped,
                          backgroundColor: Colors.grey.shade100,
                          timeZone: 'Romance Standard Time',
                          //showWeekNumber: true,
                          headerStyle: const CalendarHeaderStyle(
                            textAlign: TextAlign.start,
                            textStyle: TextStyle(
                                color: Colors.black,
                                overflow: TextOverflow.visible),
                          ),
                          viewHeaderStyle: const ViewHeaderStyle(
                            dateTextStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            dayTextStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          weekNumberStyle: const WeekNumberStyle(
                            backgroundColor: Colors.amber,
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                overflow: TextOverflow.visible),
                          ),
                          showNavigationArrow: true,
                          selectionDecoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                            shape: BoxShape.rectangle,
                          ),
                          cellBorderColor: Colors.grey.shade500,
                          todayHighlightColor: Colors.amber,
                          view: CalendarView.timelineWorkWeek,
                          timeSlotViewSettings: const TimeSlotViewSettings(
                            startHour: 6,
                            endHour: 20,
                            timeTextStyle: TextStyle(color: Colors.black),
                          ),
                          /*timeSlotViewSettings: const TimeSlotViewSettings(
                                  startHour: 7,
                                  endHour: 19,
                                  timeTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400)),*/
                          allowedViews: const [
                            CalendarView.timelineDay,
                            CalendarView.timelineWorkWeek,
                            CalendarView.timelineMonth,
                            CalendarView.month
                          ],
                          //specialRegions: controller.specialTimeRegion,
                          //monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                        );
                      } else {
                        return Container(
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget resourceBuilder(BuildContext context,
      ResourceViewHeaderDetails details) {
    if (details.resource.image != null) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade500, width: 0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: details.resource.image,
              backgroundColor: details.resource.color,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(child: Text(
                details.resource.displayName,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              )),
            ),
          ],
        ),
      );
    }
    else {
      return Container(
        color: details.resource.color,
        child: Text(details.resource.displayName),
      );
    }
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) async {
    setState(
          () {
        if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
            calendarTapDetails.targetElement != CalendarElement.appointment) {
          return;
        }

        managerCalendarController.selectedAppointment = null;
        managerCalendarController.isAllDay = false;
        managerCalendarController.subject;
        managerCalendarController.notes = '';
        managerCalendarController.newTaskResourceIds =
        calendarTapDetails.resource!.id as String;

        if (calendarTapDetails.appointments != null &&
            calendarTapDetails.appointments!.length == 1) {
          final TasksForManagerCalendar meetingDetails = calendarTapDetails
              .appointments![0];
          managerCalendarController.startDate = meetingDetails.startTime;
          managerCalendarController.endDate = meetingDetails.endTime;
          managerCalendarController.isAllDay = meetingDetails.isAllDay;
          managerCalendarController.taskId = meetingDetails.id;
          //managerCalendarController.newTaskResourceIds = meetingDetails.resourceIds!.first;
          //managerCalendarController.newTaskResourceIds = managerCalendarController.employeeCollection![managerCalendarController.selectedResourceIndex].id;
          //managerCalendarController.newTaskResourceIds = calendarTapDetails.resource!.id as String?;
          //managerCalendarController.selectedResourceIndex = calendarTapDetails.targetElement.index;

          managerCalendarController.subject =
          (meetingDetails.subject == '(No title)'
              ? ''
              : meetingDetails.subject)!;
          managerCalendarController.notes = meetingDetails.notes!;

          managerCalendarController.selectedAppointment = meetingDetails;
        } else {
          final DateTime? date = calendarTapDetails.date;
          managerCalendarController.startDate = date;
          managerCalendarController.endDate =
              date!.add(const Duration(hours: 1));
        }
        managerCalendarController.startTime = TimeOfDay(
            hour: managerCalendarController.startDate!.hour,
            minute: managerCalendarController.startDate!.minute);
        managerCalendarController.endTime = TimeOfDay(
            hour: managerCalendarController.endDate!.hour,
            minute: managerCalendarController.endDate!.minute);

        showDialog(
          context: context,
          builder: (context) =>
              Center(
                child: Material(
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.5,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      //padding: const EdgeInsets.all(0),
                      children: <Widget>[
                        Row(
                          children: [
                            Text(managerCalendarController.subject ??
                                "Sélection"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                managerCalendarController.subject = null;
                              },
                            ),
                            IconButton(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    final List<
                                        TasksForManagerCalendar> meetings = <
                                        TasksForManagerCalendar>[];
                                    //if (widget.selectedAppointment != null) dashboardController.deleteTask(selectedAppointment.id);
                                    if (managerCalendarController
                                        .selectedAppointment !=
                                        null) {
                                      managerCalendarController.events!
                                          .appointments!
                                          .removeAt(managerCalendarController
                                          .events!.appointments!
                                          .indexOf(managerCalendarController
                                          .selectedAppointment));

                                      managerCalendarController.events!
                                          .notifyListeners(
                                          CalendarDataSourceAction.remove,
                                          <TasksForManagerCalendar>[]
                                            ..add(managerCalendarController
                                                .selectedAppointment!));
                                    }
                                    //POST new task to DB
                                    managerCalendarController.addNewTask(
                                      managerCalendarController.subject!,
                                      managerCalendarController.startDate!,
                                      managerCalendarController.endDate!,
                                      managerCalendarController.isAllDay!,
                                      managerCalendarController
                                          .newTaskResourceIds!,
                                      managerCalendarController.notes,
                                      //managerCalendarController.color!,                                     //dashboardController.loginController.currentUser.id,
                                      //dashboardController.color!,
                                    );

                                    //print("addtask from editor");
                                    meetings.add(
                                      TasksForManagerCalendar(
                                        startTime: managerCalendarController
                                            .startDate,
                                        endTime: managerCalendarController
                                            .endDate,
                                        notes: managerCalendarController.notes,
                                        isAllDay: managerCalendarController
                                            .isAllDay,
                                        subject: managerCalendarController
                                            .subject == ''
                                            ? '(No title)'
                                            : managerCalendarController.subject,
                                        color: managerCalendarController.color,
                                        resourceIds: <String>[
                                          managerCalendarController
                                              .newTaskResourceIds!
                                        ],
                                      ),
                                    );

                                    managerCalendarController.events!
                                        .appointments!
                                        .add(meetings[0]);
                                    managerCalendarController.events!
                                        .notifyListeners(
                                        CalendarDataSourceAction.add, meetings);
                                    managerCalendarController
                                        .selectedAppointment = null;

                                    Navigator.pop(context);
                                    setState(() {
                                      managerCalendarController.fetchManagerTasks();

                                    });
                                  });
                                }),
                          ],
                        ),
                        Material(
                          child: ListTile(
                            contentPadding: const EdgeInsets.fromLTRB(
                                5, 2, 5, 2),
                            leading: const Icon(
                              Icons.public,
                              color: Colors.black,
                            ),
                            title: GetBuilder<AdminCalendarController>(
                                builder: (logic) {
                                  return Text(
                                    managerCalendarController.subject != null
                                        ? 'SUJET \n ${managerCalendarController
                                        .subject}'
                                        : 'SUJET',
                                    style: TextStyle(color: Colors.black),
                                  );
                                }),
                            onTap: () {
                              showDialog<Widget>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.5,
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.5,
                                      child: ListView.builder(
                                        itemCount: UserTaskSubject.values
                                            .length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: Icon(Icons.lens,
                                                color: getUserTaskPickerLensColor(
                                                    UserTaskSubject
                                                        .values[index])),
                                            title: Text(
                                              getSubjectTaskToString(
                                                  UserTaskSubject
                                                      .values[index]),
                                              //UserTaskSubject.values[index].name.toString(),
                                              /*UserTaskSubject.values[index].name
                                                    .toString()*/
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                managerCalendarController
                                                    .subject =
                                                    getSubjectTaskToString(
                                                        UserTaskSubject
                                                            .values[index]);
                                                /*UserTaskSubject.values[index].name
                                                    .toString();*/
                                                managerCalendarController
                                                    .color =
                                                    dashboardCalendarController.getTaskCardColor(
                                                        managerCalendarController
                                                            .subject!);
                                                managerCalendarController
                                                    .update();
                                              });
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 200),
                                                      () {
                                                    // When task is over, close the dialog
                                                    Navigator.pop(context);
                                                  });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ).then((dynamic value) {
                                setState(() {
                                  managerCalendarController.subject;
                                  //dashboardController.color = getTaskCardColor(dashboardController.subject);
                                });
                              });
                            },
                          ),
                        ),
                        const Divider(
                          height: 1.0,
                          thickness: 1,
                        ),
                        Material(
                          child: ListTile(
                            contentPadding: const EdgeInsets.fromLTRB(
                                5, 2, 5, 2),
                            leading: const Icon(
                              Icons.access_time,
                              color: Colors.black,
                            ),
                            title: Row(
                              children: <Widget>[
                                const Expanded(
                                  child: Text(
                                    'jour entier',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Material(
                                  child: StatefulBuilder(builder:
                                      (BuildContext context,
                                      StateSetter setState) {
                                    return CupertinoSwitch(
                                      value: managerCalendarController
                                          .isAllDay!,
                                      //inactiveTrackColor: Colors.grey,
                                      //activeTrackColor: Colors.blue,
                                      onChanged: (bool value) {
                                        setState(() {
                                          managerCalendarController.isAllDay =
                                              value;
                                        });
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Material(
                          child: ListTile(
                              contentPadding: const EdgeInsets.fromLTRB(
                                  5, 2, 5, 2),
                              leading: const Text(''),
                              title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 7,
                                      child: Material(
                                        child: GestureDetector(
                                            child: Text(
                                                DateFormat(
                                                    'EEE, MMM dd yyyy', 'fr')
                                                    .format(
                                                    managerCalendarController
                                                        .startDate!),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            onTap: () async {
                                              final DateTime? date =
                                              await showDatePicker(
                                                locale: const Locale('fr'),
                                                context: context,
                                                initialDate:
                                                managerCalendarController
                                                    .startDate!,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100),
                                              );

                                              if (date != null &&
                                                  date !=
                                                      managerCalendarController
                                                          .startDate) {
                                                setState(() {
                                                  final Duration difference =
                                                  managerCalendarController
                                                      .endDate!
                                                      .difference(
                                                      managerCalendarController
                                                          .startDate!);
                                                  managerCalendarController
                                                      .startDate =
                                                      DateTime(
                                                          date.year,
                                                          date.month,
                                                          date.day,
                                                          managerCalendarController
                                                              .startTime!.hour,
                                                          managerCalendarController
                                                              .startTime!
                                                              .minute,
                                                          0);
                                                  managerCalendarController
                                                      .endDate =
                                                      managerCalendarController
                                                          .startDate!
                                                          .add(difference);
                                                  managerCalendarController
                                                      .endTime =
                                                      TimeOfDay(
                                                          hour: managerCalendarController
                                                              .endDate!.hour,
                                                          minute: managerCalendarController
                                                              .endDate!.minute);
                                                });
                                              }
                                            }),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: managerCalendarController
                                            .isAllDay!
                                            ? const Text('')
                                            : GestureDetector(
                                            child: Text(
                                                DateFormat('Hm', ('fr')).format(
                                                    managerCalendarController
                                                        .startDate!),
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                            onTap: () async {
                                              final TimeOfDay? time =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay(
                                                      hour:
                                                      managerCalendarController
                                                          .startTime!
                                                          .hour,
                                                      minute:
                                                      managerCalendarController
                                                          .startTime!
                                                          .minute));

                                              if (time != null &&
                                                  time !=
                                                      managerCalendarController
                                                          .startTime) {
                                                setState(() {
                                                  managerCalendarController
                                                      .startTime =
                                                      time;
                                                  final Duration difference =
                                                  managerCalendarController
                                                      .endDate!
                                                      .difference(
                                                      managerCalendarController
                                                          .startDate!);
                                                  managerCalendarController
                                                      .startDate =
                                                      DateTime(
                                                          managerCalendarController
                                                              .startDate!.year,
                                                          managerCalendarController
                                                              .startDate!.month,
                                                          managerCalendarController
                                                              .startDate!.day,
                                                          managerCalendarController
                                                              .startTime!.hour,
                                                          managerCalendarController
                                                              .startTime!
                                                              .minute,
                                                          0);
                                                  managerCalendarController
                                                      .endDate =
                                                      managerCalendarController
                                                          .startDate!
                                                          .add(difference);
                                                  managerCalendarController
                                                      .endTime =
                                                      TimeOfDay(
                                                          hour:
                                                          managerCalendarController
                                                              .endDate!.hour,
                                                          minute:
                                                          managerCalendarController
                                                              .endDate!
                                                              .minute);
                                                });
                                              }
                                            })),
                                  ])),
                        ),
                        Material(
                          child: ListTile(
                              contentPadding: const EdgeInsets.fromLTRB(
                                  5, 2, 5, 2),
                              leading: const Text(''),
                              title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 7,
                                      child: GestureDetector(
                                          child: Text(
                                              DateFormat(
                                                  'EEE, MMM dd yyyy', ('fr'))
                                                  .format(
                                                  managerCalendarController
                                                      .endDate!),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          onTap: () async {
                                            final DateTime? date =
                                            await showDatePicker(
                                              locale: const Locale('fr'),
                                              context: context,
                                              initialDate:
                                              managerCalendarController
                                                  .endDate!,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2100),
                                            );

                                            if (date != null &&
                                                date !=
                                                    managerCalendarController
                                                        .endDate) {
                                              setState(() {
                                                final Duration difference =
                                                managerCalendarController
                                                    .endDate!
                                                    .difference(
                                                    managerCalendarController
                                                        .startDate!);
                                                managerCalendarController
                                                    .endDate =
                                                    DateTime(
                                                        date.year,
                                                        date.month,
                                                        date.day,
                                                        managerCalendarController
                                                            .endTime!.hour,
                                                        managerCalendarController
                                                            .endTime!.minute,
                                                        0);
                                                if (managerCalendarController
                                                    .endDate!
                                                    .isBefore(
                                                    managerCalendarController
                                                        .startDate!)) {
                                                  managerCalendarController
                                                      .startDate =
                                                      managerCalendarController
                                                          .endDate!
                                                          .subtract(difference);
                                                  managerCalendarController
                                                      .startTime =
                                                      TimeOfDay(
                                                          hour: managerCalendarController
                                                              .startDate!.hour,
                                                          minute: managerCalendarController
                                                              .startDate!
                                                              .minute);
                                                }
                                              });
                                            }
                                          }),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: managerCalendarController
                                            .isAllDay!
                                            ? const Text('')
                                            : GestureDetector(
                                            child: Text(
                                                DateFormat('Hm', 'fr').format(
                                                    managerCalendarController
                                                        .endDate!),
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                            onTap: () async {
                                              final TimeOfDay? time =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay(
                                                      hour:
                                                      managerCalendarController
                                                          .endTime!.hour,
                                                      minute:
                                                      managerCalendarController
                                                          .endTime!
                                                          .minute));

                                              if (time != null &&
                                                  time !=
                                                      managerCalendarController
                                                          .endTime) {
                                                setState(() {
                                                  managerCalendarController
                                                      .endTime =
                                                      time;
                                                  final Duration difference =
                                                  managerCalendarController
                                                      .endDate!
                                                      .difference(
                                                      managerCalendarController
                                                          .startDate!);
                                                  managerCalendarController
                                                      .endDate =
                                                      DateTime(
                                                          managerCalendarController
                                                              .endDate!.year,
                                                          managerCalendarController
                                                              .endDate!.month,
                                                          managerCalendarController
                                                              .endDate!.day,
                                                          managerCalendarController
                                                              .endTime!.hour,
                                                          managerCalendarController
                                                              .endTime!.minute,
                                                          0);
                                                  if (managerCalendarController
                                                      .endDate!
                                                      .isBefore(
                                                      managerCalendarController
                                                          .startDate!)) {
                                                    managerCalendarController
                                                        .startDate =
                                                        managerCalendarController
                                                            .endDate!
                                                            .subtract(
                                                            difference);
                                                    managerCalendarController
                                                        .startTime =
                                                        TimeOfDay(
                                                            hour:
                                                            managerCalendarController
                                                                .startDate!
                                                                .hour,
                                                            minute:
                                                            managerCalendarController
                                                                .startDate!
                                                                .minute);
                                                  }
                                                });
                                              }
                                            })),
                                  ])),
                        ),
                        /*ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    leading: const Icon(
                      Icons.public,
                      color: Colors.black87,
                    ),
                    title: Text(
                      'SUJET \n ${widget.subject}',
                    ),
                    onTap: () {
                      showDialog<Widget>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return UserTaskSubjectPicker(
                            subject: widget.subject,
                          );
                        },
                      ).then((dynamic value) {
                        setState(() {
                          widget.subject;
                          widget.color = getTaskCardColor(widget.subject);
                        });
                      });
                    },
                    ),*/
                        const Divider(
                          height: 1.0,
                          thickness: 1,
                        ),
                        /*ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                        */ /*leading: Icon(
                      Icons.lens,
                      color: widget.colorCollection![widget.selectedColorIndex!],
                    ),*/ /*
                        */ /*title: Text(
                      widget.colorNames![widget.selectedColorIndex!],
                    ),*/ /*
                        onTap: () {
                          */ /*showDialog<Widget>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ColorPicker(
                            colorCollection: widget.colorCollection!,
                            selectedColorIndex: widget.selectedColorIndex!,
                            colorNames: widget.colorNames!,
                          );
                        },
                      ).then((dynamic value) => setState(() {}));*/ /*
                        },
                      ),*/
                        /*const Divider(
                        height: 1.0,
                        thickness: 1,
                      ),
                      const Divider(
                        height: 1.0,
                        thickness: 1,
                      ),*/
                        Material(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(5),
                            leading: const Icon(
                              Icons.subject,
                              color: Colors.black87,
                            ),
                            title: TextField(
                              controller: TextEditingController(
                                  text: managerCalendarController.notes),
                              onChanged: (String value) {
                                managerCalendarController.notes = value;
                              },
                              keyboardType: TextInputType.name,
                              maxLines: null,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Add description',
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1.0,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        );
      },
    );
  }

/*void onCalendarTapped(CalendarTapDetails calendarTapDetails) async {
    setState(
          () {
        if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
            calendarTapDetails.targetElement != CalendarElement.appointment) {
          return;
        }

        managerCalendarController.selectedAppointment = null;
        managerCalendarController.isAllDay = false;
        managerCalendarController.subject;
        managerCalendarController.notes = '';

        if (calendarTapDetails.appointments != null &&
            calendarTapDetails.appointments!.length == 1) {
          final TasksForManagerCalendar meetingDetails =
          calendarTapDetails.appointments![0];
          managerCalendarController.startDate = meetingDetails.startTime;
          managerCalendarController.endDate = meetingDetails.endTime;
          managerCalendarController.isAllDay = meetingDetails.isAllDay;
          managerCalendarController.taskId = meetingDetails.id;
          managerCalendarController.newTaskResourceIds = meetingDetails.resourceIds.toString();


          managerCalendarController.subject =
          (meetingDetails.subject == '(No title)'
              ? ''
              : meetingDetails.subject)!;
          managerCalendarController.notes = meetingDetails.notes!;

          managerCalendarController.selectedAppointment = meetingDetails;
        } else {
          final DateTime? date = calendarTapDetails.date;
          managerCalendarController.startDate = date;
          managerCalendarController.endDate =
              date!.add(const Duration(hours: 1));
        }
        managerCalendarController.startTime = TimeOfDay(
            hour: managerCalendarController.startDate!.hour,
            minute: managerCalendarController.startDate!.minute);
        managerCalendarController.endTime = TimeOfDay(
            hour: managerCalendarController.endDate!.hour,
            minute: managerCalendarController.endDate!.minute);

        showDialog(
          context: context,
          builder: (context) => Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              //height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                //padding: const EdgeInsets.all(0),
                children: <Widget>[
                  */ /*Row(
                    children: [
                      Text(managerCalendarController.subject ?? "Sélection"),
                    ],
                  ),*/ /*
                  Material(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            managerCalendarController.subject = null;
                            //managerCalendarController.resourceName = null;
                          },
                        ),
                        IconButton(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            icon: const Icon(
                              Icons.done,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                final List<TasksForManagerCalendar> meetings =
                                <TasksForManagerCalendar>[];
                                //if (widget.selectedAppointment != null) dashboardController.deleteTask(selectedAppointment.id);
                                if (managerCalendarController
                                    .selectedAppointment !=
                                    null) {
                                  managerCalendarController
                                      .events!.appointments!
                                      .removeAt(managerCalendarController
                                      .events!.appointments!
                                      .indexOf(managerCalendarController
                                      .selectedAppointment));

                                  managerCalendarController.events!
                                      .notifyListeners(
                                      CalendarDataSourceAction.remove,
                                      <TasksForManagerCalendar>[]..add(
                                          managerCalendarController
                                              .selectedAppointment!));
                                }
                                //POST new task to DB
                                managerCalendarController.addNewTask(
                                  managerCalendarController.subject!,
                                  managerCalendarController.startDate!,
                                  managerCalendarController.endDate!,
                                  managerCalendarController.isAllDay!,
                                  managerCalendarController.newTaskResourceIds!,
                                  managerCalendarController.notes,

                                  //dashboardController.color!,
                                );

                                //print("addtask from editor");
                                meetings.add(
                                  TasksForManagerCalendar(
                                    startTime:
                                    managerCalendarController.startDate,
                                    endTime: managerCalendarController.endDate,
                                    notes: managerCalendarController.notes,
                                    isAllDay:
                                    managerCalendarController.isAllDay,
                                    subject:
                                    managerCalendarController.subject == ''
                                        ? '(No title)'
                                        : managerCalendarController.subject,
                                    color: managerCalendarController.color,
                                    resourceIds: [
                                      managerCalendarController
                                          .newTaskResourceIds!
                                    ],
                                    //resourceIds: dashboardController.user.id,
                                  ),
                                );

                                managerCalendarController.events!.appointments!
                                    .add(meetings[0]);
                                managerCalendarController.events!
                                    .notifyListeners(
                                    CalendarDataSourceAction.add, meetings);
                                managerCalendarController.selectedAppointment =
                                null;

                                Navigator.pop(context);
                                setState(() {
                                  managerCalendarController.update();
                                });
                              });
                            }),
                      ],
                    ),
                  ),
                  Material(
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      leading: const Icon(
                        Icons.public,
                        color: Colors.black,
                      ),
                      title: GetBuilder<AdminCalendarController>(
                          builder: (logic) {
                            return Text(
                              managerCalendarController.subject != null
                                  ? 'SUJET \n ${managerCalendarController.subject}'
                                  : 'SUJET',
                              style: TextStyle(color: Colors.black),
                            );
                          }),
                      onTap: () {
                        showDialog<Widget>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                MediaQuery.of(context).size.height * 0.5,
                                child: ListView.builder(
                                  itemCount: UserTaskSubject.values.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Icon(Icons.lens,
                                          color: getUserTaskPickerLensColor(
                                              UserTaskSubject.values[index])),
                                      title: Text(
                                        getSubjectTaskToString(
                                            UserTaskSubject.values[index]),
                                        //UserTaskSubject.values[index].name.toString(),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          managerCalendarController.subject =
                                              getSubjectTaskToString(
                                                  UserTaskSubject
                                                      .values[index]);
                                          */ /*UserTaskSubject.values[index].name
                                                  .toString();*/ /*
                                          managerCalendarController.color =
                                              getTaskCardColor(
                                                  managerCalendarController
                                                      .subject!);
                                          managerCalendarController.update();
                                        });
                                        Future.delayed(
                                            const Duration(milliseconds: 200),
                                                () {
                                              // When task is over, close the dialog
                                              Navigator.pop(context);
                                            });
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ).then((dynamic value) {
                          setState(() {
                            managerCalendarController.subject;
                            //dashboardController.color = getTaskCardColor(dashboardController.subject);
                          });
                        });
                      },
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),
                  */ /*Material(
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      leading: const Icon(
                        EvaIcons.person,
                        color: Colors.black,
                      ),
                      title: GetBuilder<AdminCalendarController>(
                          builder: (logic) {
                            return Text(
                              */ /**/ /*'Destinataire',
                          style: TextStyle(color: Colors.black),*/ /**/ /*
                              managerCalendarController.resourceName != null
                                  ? 'DESTINATAIRE \n ${managerCalendarController.resourceName}'
                                  : 'DESTINATAIRE',
                              style: TextStyle(color: Colors.black),
                            );
                          }),
                      onTap: () {
                        showDialog<Widget>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                MediaQuery.of(context).size.height * 0.5,
                                child: ListView.builder(
                                  itemCount:
                                  managerCalendarController.users!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Icon(Icons.lens),
                                      title: Text(
                                        managerCalendarController
                                            .users![index].name!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          managerCalendarController
                                              .newTaskResourceIds =
                                          managerCalendarController
                                              .users![index].id!;
                                          managerCalendarController
                                              .resourceName =
                                              managerCalendarController
                                                  .users![index].name;
                                          managerCalendarController.update();
                                        });
                                        Future.delayed(
                                            const Duration(milliseconds: 200),
                                                () {
                                              // When task is over, close the dialog
                                              Navigator.pop(context);
                                            });
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ).then((dynamic value) {
                          setState(() {
                            managerCalendarController.newTaskResourceIds;
                            managerCalendarController.resourceName;
                            //dashboardController.color = getTaskCardColor(dashboardController.subject);
                          });
                        });
                      },
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),*/ /*
                  Material(
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      leading: const Icon(
                        Icons.access_time,
                        color: Colors.black,
                      ),
                      title: Row(
                        children: <Widget>[
                          const Expanded(
                            child: Text(
                              'jour entier',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Material(
                            child: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return CupertinoSwitch(
                                value: managerCalendarController.isAllDay!,
                                //inactiveTrackColor: Colors.grey,
                                //activeTrackColor: Colors.blue,
                                onChanged: (bool value) {
                                  setState(() {
                                    managerCalendarController.isAllDay = value;
                                  });
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    child: ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                        leading: const Text(''),
                        title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 7,
                                child: GestureDetector(
                                    child: Text(
                                        DateFormat('EEE, MMM dd yyyy', 'fr')
                                            .format(managerCalendarController
                                            .startDate!),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(color: Colors.black)),
                                    onTap: () async {
                                      final DateTime? date =
                                      await showDatePicker(
                                        locale: const Locale('fr'),
                                        context: context,
                                        initialDate: managerCalendarController
                                            .startDate!,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );

                                      if (date != null &&
                                          date !=
                                              managerCalendarController
                                                  .startDate) {
                                        setState(() {
                                          final Duration difference =
                                          managerCalendarController.endDate!
                                              .difference(
                                              managerCalendarController
                                                  .startDate!);
                                          managerCalendarController.startDate =
                                              DateTime(
                                                  date.year,
                                                  date.month,
                                                  date.day,
                                                  managerCalendarController
                                                      .startTime!.hour,
                                                  managerCalendarController
                                                      .startTime!.minute,
                                                  0);
                                          managerCalendarController.endDate =
                                              managerCalendarController
                                                  .startDate!
                                                  .add(difference);
                                          managerCalendarController.endTime =
                                              TimeOfDay(
                                                  hour:
                                                  managerCalendarController
                                                      .endDate!.hour,
                                                  minute:
                                                  managerCalendarController
                                                      .endDate!.minute);
                                        });
                                      }
                                    }),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: managerCalendarController.isAllDay!
                                      ? const Text('')
                                      : GestureDetector(
                                      child: Text(
                                          DateFormat('Hm', ('fr')).format(
                                              managerCalendarController
                                                  .startDate!),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                      onTap: () async {
                                        final TimeOfDay? time =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay(
                                                hour:
                                                managerCalendarController
                                                    .startTime!
                                                    .hour,
                                                minute:
                                                managerCalendarController
                                                    .startTime!
                                                    .minute));

                                        if (time != null &&
                                            time !=
                                                managerCalendarController
                                                    .startTime) {
                                          setState(() {
                                            managerCalendarController
                                                .startTime = time;
                                            final Duration difference =
                                            managerCalendarController
                                                .endDate!
                                                .difference(
                                                managerCalendarController
                                                    .startDate!);
                                            managerCalendarController.startDate =
                                                DateTime(
                                                    managerCalendarController
                                                        .startDate!.year,
                                                    managerCalendarController
                                                        .startDate!.month,
                                                    managerCalendarController
                                                        .startDate!.day,
                                                    managerCalendarController
                                                        .startTime!.hour,
                                                    managerCalendarController
                                                        .startTime!.minute,
                                                    0);
                                            managerCalendarController
                                                .endDate =
                                                managerCalendarController
                                                    .startDate!
                                                    .add(difference);
                                            managerCalendarController.endTime =
                                                TimeOfDay(
                                                    hour:
                                                    managerCalendarController
                                                        .endDate!.hour,
                                                    minute:
                                                    managerCalendarController
                                                        .endDate!
                                                        .minute);
                                          });
                                        }
                                      })),
                            ])),
                  ),
                  Material(
                    child: ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                        leading: const Text(''),
                        title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 7,
                                child: GestureDetector(
                                    child: Text(
                                        DateFormat('EEE, MMM dd yyyy', ('fr'))
                                            .format(managerCalendarController
                                            .endDate!),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(color: Colors.black)),
                                    onTap: () async {
                                      final DateTime? date =
                                      await showDatePicker(
                                        locale: const Locale('fr'),
                                        context: context,
                                        initialDate:
                                        managerCalendarController.endDate!,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );

                                      if (date != null &&
                                          date !=
                                              managerCalendarController
                                                  .endDate) {
                                        setState(() {
                                          final Duration difference =
                                          managerCalendarController.endDate!
                                              .difference(
                                              managerCalendarController
                                                  .startDate!);
                                          managerCalendarController.endDate =
                                              DateTime(
                                                  date.year,
                                                  date.month,
                                                  date.day,
                                                  managerCalendarController
                                                      .endTime!.hour,
                                                  managerCalendarController
                                                      .endTime!.minute,
                                                  0);
                                          if (managerCalendarController.endDate!
                                              .isBefore(
                                              managerCalendarController
                                                  .startDate!)) {
                                            managerCalendarController
                                                .startDate =
                                                managerCalendarController
                                                    .endDate!
                                                    .subtract(difference);
                                            managerCalendarController
                                                .startTime =
                                                TimeOfDay(
                                                    hour:
                                                    managerCalendarController
                                                        .startDate!.hour,
                                                    minute:
                                                    managerCalendarController
                                                        .startDate!.minute);
                                          }
                                        });
                                      }
                                    }),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: managerCalendarController.isAllDay!
                                      ? const Text('')
                                      : GestureDetector(
                                      child: Text(
                                          DateFormat('Hm', 'fr').format(
                                              managerCalendarController
                                                  .endDate!),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                      onTap: () async {
                                        final TimeOfDay? time =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay(
                                                hour:
                                                managerCalendarController
                                                    .endTime!.hour,
                                                minute:
                                                managerCalendarController
                                                    .endTime!
                                                    .minute));

                                        if (time != null &&
                                            time !=
                                                managerCalendarController
                                                    .endTime) {
                                          setState(() {
                                            managerCalendarController
                                                .endTime = time;
                                            final Duration difference =
                                            managerCalendarController
                                                .endDate!
                                                .difference(
                                                managerCalendarController
                                                    .startDate!);
                                            managerCalendarController
                                                .endDate =
                                                DateTime(
                                                    managerCalendarController
                                                        .endDate!.year,
                                                    managerCalendarController
                                                        .endDate!.month,
                                                    managerCalendarController
                                                        .endDate!.day,
                                                    managerCalendarController
                                                        .endTime!.hour,
                                                    managerCalendarController
                                                        .endTime!.minute,
                                                    0);
                                            if (managerCalendarController
                                                .endDate!
                                                .isBefore(
                                                managerCalendarController
                                                    .startDate!)) {
                                              managerCalendarController
                                                  .startDate =
                                                  managerCalendarController
                                                      .endDate!
                                                      .subtract(difference);
                                              managerCalendarController
                                                  .startTime =
                                                  TimeOfDay(
                                                      hour:
                                                      managerCalendarController
                                                          .startDate!
                                                          .hour,
                                                      minute:
                                                      managerCalendarController
                                                          .startDate!
                                                          .minute);
                                            }
                                          });
                                        }
                                      })),
                            ])),
                  ),
                  */ /*ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  leading: const Icon(
                    Icons.public,
                    color: Colors.black87,
                  ),
                  title: Text(
                    'SUJET \n ${widget.subject}',
                  ),
                  onTap: () {
                    showDialog<Widget>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return UserTaskSubjectPicker(
                          subject: widget.subject,
                        );
                      },
                    ).then((dynamic value) {
                      setState(() {
                        widget.subject;
                        widget.color = getTaskCardColor(widget.subject);
                      });
                    });
                  },
                  ),*/ /*
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),
                  */ /*ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      */ /* */ /*leading: Icon(
                    Icons.lens,
                    color: widget.colorCollection![widget.selectedColorIndex!],
                  ),*/ /* */ /*
                      */ /* */ /*title: Text(
                    widget.colorNames![widget.selectedColorIndex!],
                  ),*/ /* */ /*
                      onTap: () {
                        */ /* */ /*showDialog<Widget>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return ColorPicker(
                          colorCollection: widget.colorCollection!,
                          selectedColorIndex: widget.selectedColorIndex!,
                          colorNames: widget.colorNames!,
                        );
                      },
                    ).then((dynamic value) => setState(() {}));*/ /* */ /*
                      },
                    ),*/ /*
                  */ /*const Divider(
                      height: 1.0,
                      thickness: 1,
                    ),
                    const Divider(
                      height: 1.0,
                      thickness: 1,
                    ),*/ /*
                  Material(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(5),
                      leading: const Icon(
                        Icons.subject,
                        color: Colors.black87,
                      ),
                      title: TextField(
                        controller: TextEditingController(
                            text: managerCalendarController.notes),
                        onChanged: (String value) {
                          managerCalendarController.notes = value;
                        },
                        keyboardType: TextInputType.name,
                        maxLines: null,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add description',
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }*/
}
