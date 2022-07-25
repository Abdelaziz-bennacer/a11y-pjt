import 'package:a11y_pjt/app/modules/base/views/components/dash_board_calendar/user_calendar_datasource.dart';
import 'package:a11y_pjt/app/modules/base/views/components/dash_board_calendar/usertask_subject_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../data/models/usertask_model/usertask_model.dart';
import 'dashboard_calendar_component_controller.dart';

class DashBoardCalendarComponent extends StatefulWidget {
  @override
  State<DashBoardCalendarComponent> createState() =>
      _DashBoardCalendarComponentState();
}

class _DashBoardCalendarComponentState
    extends State<DashBoardCalendarComponent> {
  final CalendarController _controller = CalendarController();
  final dashboardController = Get.put(DashBoardCalendarController());

  DateTime? _datePicked = DateTime.now();

  void _viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      _datePicked = viewChangedDetails
          .visibleDates[viewChangedDetails.visibleDates.length ~/ 2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardCalendarController>(builder: (logic) {
      return Container(
        width: double.infinity,
        height: Get.height * 1,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: FutureBuilder<List<UserTask>>(
          future: dashboardController.fetchUserTasks(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return GetBuilder<DashBoardCalendarController>(
                builder: (ctr) =>
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Expanded(
                        child: SfCalendar(
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
                            textStyle: TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          showNavigationArrow: true,
                          selectionDecoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(4)),
                            shape: BoxShape.rectangle,
                          ),
                          todayHighlightColor: Colors.amber,
                        ),
                      ),
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
        ),
      );
    });
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) async {
    setState(
          () {
        if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
            calendarTapDetails.targetElement != CalendarElement.appointment) {
          return;
        }

        dashboardController.selectedAppointment = null;
        dashboardController.isAllDay = false;
        dashboardController.subject;
        dashboardController.notes = '';

        if (calendarTapDetails.appointments != null &&
            calendarTapDetails.appointments!.length == 1) {
          final UserTask meetingDetails = calendarTapDetails.appointments![0];
          dashboardController.startDate = meetingDetails.startTime;
          dashboardController.endDate = meetingDetails.endTime;
          dashboardController.isAllDay = meetingDetails.isAllDay;
          dashboardController.taskId = meetingDetails.id;

          dashboardController.subject = (meetingDetails.subject == '(No title)'
              ? ''
              : meetingDetails.subject)!;
          dashboardController.notes = meetingDetails.notes!;

          dashboardController.selectedAppointment = meetingDetails;
        } else {
          final DateTime? date = calendarTapDetails.date;
          dashboardController.startDate = date;
          dashboardController.endDate = date!.add(const Duration(hours: 1));
        }
        dashboardController.startTime = TimeOfDay(
            hour: dashboardController.startDate!.hour,
            minute: dashboardController.startDate!.minute);
        dashboardController.endTime = TimeOfDay(
            hour: dashboardController.endDate!.hour,
            minute: dashboardController.endDate!.minute);

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
                            Text(dashboardController.subject ?? "Sélection"),
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
                                dashboardController.subject = null;
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
                                    final List<UserTask> meetings = <UserTask>[
                                    ];
                                    //if (widget.selectedAppointment != null) dashboardController.deleteTask(selectedAppointment.id);
                                    if (dashboardController
                                        .selectedAppointment !=
                                        null) {
                                      dashboardController.events!.appointments!
                                          .removeAt(dashboardController
                                          .events!.appointments!
                                          .indexOf(dashboardController
                                          .selectedAppointment));

                                      dashboardController.events!
                                          .notifyListeners(
                                          CalendarDataSourceAction.remove,
                                          <UserTask>[]
                                            ..add(dashboardController
                                                .selectedAppointment!));
                                    }
                                    //POST new task to DB
                                    dashboardController.addNewTask(
                                      dashboardController.subject!,
                                      dashboardController.startDate!,
                                      dashboardController.endDate!,
                                      dashboardController.isAllDay!,
                                      dashboardController.loginController
                                          .currentUser.id.toString(),
                                      dashboardController.notes,
                                      //dashboardController.loginController.currentUser.id,
                                      //dashboardController.color!,
                                    );

                                    //print("addtask from editor");
                                    meetings.add(
                                      UserTask(
                                        startTime: dashboardController
                                            .startDate,
                                        endTime: dashboardController.endDate,
                                        notes: dashboardController.notes,
                                        isAllDay: dashboardController.isAllDay,
                                        subject: dashboardController.subject ==
                                            ''
                                            ? '(No title)'
                                            : dashboardController.subject,
                                        color: dashboardController.color,
                                        //resourceIds: dashboardController.user.id,
                                      ),
                                    );

                                    dashboardController.events!.appointments!
                                        .add(meetings[0]);
                                    dashboardController.events!.notifyListeners(
                                        CalendarDataSourceAction.add, meetings);
                                    dashboardController.selectedAppointment =
                                    null;

                                    Navigator.pop(context);
                                    setState(() {
                                      dashboardController.fetchUserTasks();
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
                            title: GetBuilder<DashBoardCalendarController>(
                                builder: (logic) {
                                  return Text(
                                    dashboardController.subject != null
                                        ? 'SUJET \n ${dashboardController
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
                                                dashboardController.subject =
                                                    getSubjectTaskToString(
                                                        UserTaskSubject
                                                            .values[index]);
                                                /*UserTaskSubject.values[index].name
                                                    .toString();*/
                                                dashboardController.color =
                                                    getTaskCardColor(
                                                        dashboardController
                                                            .subject!);
                                                dashboardController.update();
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
                                  dashboardController.subject;
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
                                      value: dashboardController.isAllDay!,
                                      //inactiveTrackColor: Colors.grey,
                                      //activeTrackColor: Colors.blue,
                                      onChanged: (bool value) {
                                        setState(() {
                                          dashboardController.isAllDay = value;
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
                                                    dashboardController
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
                                                dashboardController.startDate!,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100),
                                              );

                                              if (date != null &&
                                                  date !=
                                                      dashboardController
                                                          .startDate) {
                                                setState(() {
                                                  final Duration difference =
                                                  dashboardController.endDate!
                                                      .difference(
                                                      dashboardController
                                                          .startDate!);
                                                  dashboardController
                                                      .startDate =
                                                      DateTime(
                                                          date.year,
                                                          date.month,
                                                          date.day,
                                                          dashboardController
                                                              .startTime!.hour,
                                                          dashboardController
                                                              .startTime!
                                                              .minute,
                                                          0);
                                                  dashboardController.endDate =
                                                      dashboardController
                                                          .startDate!
                                                          .add(difference);
                                                  dashboardController.endTime =
                                                      TimeOfDay(
                                                          hour: dashboardController
                                                              .endDate!.hour,
                                                          minute: dashboardController
                                                              .endDate!.minute);
                                                });
                                              }
                                            }),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: dashboardController.isAllDay!
                                            ? const Text('')
                                            : GestureDetector(
                                            child: Text(
                                                DateFormat('Hm', ('fr')).format(
                                                    dashboardController
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
                                                      dashboardController
                                                          .startTime!
                                                          .hour,
                                                      minute:
                                                      dashboardController
                                                          .startTime!
                                                          .minute));

                                              if (time != null &&
                                                  time !=
                                                      dashboardController
                                                          .startTime) {
                                                setState(() {
                                                  dashboardController
                                                      .startTime =
                                                      time;
                                                  final Duration difference =
                                                  dashboardController.endDate!
                                                      .difference(
                                                      dashboardController
                                                          .startDate!);
                                                  dashboardController
                                                      .startDate =
                                                      DateTime(
                                                          dashboardController
                                                              .startDate!.year,
                                                          dashboardController
                                                              .startDate!.month,
                                                          dashboardController
                                                              .startDate!.day,
                                                          dashboardController
                                                              .startTime!.hour,
                                                          dashboardController
                                                              .startTime!
                                                              .minute,
                                                          0);
                                                  dashboardController.endDate =
                                                      dashboardController
                                                          .startDate!
                                                          .add(difference);
                                                  dashboardController.endTime =
                                                      TimeOfDay(
                                                          hour:
                                                          dashboardController
                                                              .endDate!.hour,
                                                          minute:
                                                          dashboardController
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
                                                  dashboardController.endDate!),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          onTap: () async {
                                            final DateTime? date =
                                            await showDatePicker(
                                              locale: const Locale('fr'),
                                              context: context,
                                              initialDate:
                                              dashboardController.endDate!,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2100),
                                            );

                                            if (date != null &&
                                                date != dashboardController
                                                    .endDate) {
                                              setState(() {
                                                final Duration difference =
                                                dashboardController.endDate!
                                                    .difference(
                                                    dashboardController
                                                        .startDate!);
                                                dashboardController.endDate =
                                                    DateTime(
                                                        date.year,
                                                        date.month,
                                                        date.day,
                                                        dashboardController
                                                            .endTime!.hour,
                                                        dashboardController
                                                            .endTime!.minute,
                                                        0);
                                                if (dashboardController.endDate!
                                                    .isBefore(
                                                    dashboardController
                                                        .startDate!)) {
                                                  dashboardController
                                                      .startDate =
                                                      dashboardController
                                                          .endDate!
                                                          .subtract(difference);
                                                  dashboardController
                                                      .startTime =
                                                      TimeOfDay(
                                                          hour: dashboardController
                                                              .startDate!.hour,
                                                          minute: dashboardController
                                                              .startDate!
                                                              .minute);
                                                }
                                              });
                                            }
                                          }),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: dashboardController.isAllDay!
                                            ? const Text('')
                                            : GestureDetector(
                                            child: Text(
                                                DateFormat('Hm', 'fr').format(
                                                    dashboardController
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
                                                      dashboardController
                                                          .endTime!.hour,
                                                      minute:
                                                      dashboardController
                                                          .endTime!
                                                          .minute));

                                              if (time != null &&
                                                  time !=
                                                      dashboardController
                                                          .endTime) {
                                                setState(() {
                                                  dashboardController.endTime =
                                                      time;
                                                  final Duration difference =
                                                  dashboardController.endDate!
                                                      .difference(
                                                      dashboardController
                                                          .startDate!);
                                                  dashboardController.endDate =
                                                      DateTime(
                                                          dashboardController
                                                              .endDate!.year,
                                                          dashboardController
                                                              .endDate!.month,
                                                          dashboardController
                                                              .endDate!.day,
                                                          dashboardController
                                                              .endTime!.hour,
                                                          dashboardController
                                                              .endTime!.minute,
                                                          0);
                                                  if (dashboardController
                                                      .endDate!
                                                      .isBefore(
                                                      dashboardController
                                                          .startDate!)) {
                                                    dashboardController
                                                        .startDate =
                                                        dashboardController
                                                            .endDate!
                                                            .subtract(
                                                            difference);
                                                    dashboardController
                                                        .startTime =
                                                        TimeOfDay(
                                                            hour:
                                                            dashboardController
                                                                .startDate!
                                                                .hour,
                                                            minute:
                                                            dashboardController
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
                                  text: dashboardController.notes),
                              onChanged: (String value) {
                                dashboardController.notes = value;
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
}
