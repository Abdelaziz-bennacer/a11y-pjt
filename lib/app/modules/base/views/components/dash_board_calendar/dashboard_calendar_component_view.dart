import 'package:a11y_pjt/app/data/models/user_model/user_calendar_datasource.dart';
import 'package:a11y_pjt/app/modules/base/controllers/base_controller.dart';
import 'package:a11y_pjt/app/modules/base/views/components/dash_board_calendar/usertask_subject_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../data/models/usertask_model/usertask_model.dart';
import '../../../controllers/dashboard_calendar_component_controller.dart';

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
        //width: double.infinity,
        height: Get.height * 0.9,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: FutureBuilder<List<UserTask>>(
          future: dashboardController.fetchUserTasks(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return GetBuilder<DashBoardCalendarController>(
                builder: (ctr) =>
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo.shade900, width: 3),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(7)),
                          child: SfCalendar(
                            controller: _controller,
                            backgroundColor: Colors.grey.shade100,
                            cellBorderColor: Colors.grey.shade500,
                            headerStyle: CalendarHeaderStyle(
                              backgroundColor: Colors.grey.shade200,
                              textStyle: const TextStyle(color: Colors.black),
                            ),
                            viewHeaderStyle: ViewHeaderStyle(
                              backgroundColor: Colors.grey.shade200,
                              dateTextStyle: const TextStyle(color: Colors.black),
                              dayTextStyle: const TextStyle(color: Colors.black),
                            ),
                            view: CalendarView.workWeek,
                            onViewChanged: _viewChanged,
                            timeSlotViewSettings: const TimeSlotViewSettings(
                              startHour: 5,
                              endHour: 24,
                              timeTextStyle: TextStyle(color: Colors.black),
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
                                  color: Colors.black, fontSize: 15),
                            ),
                            showNavigationArrow: true,
                            selectionDecoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                              shape: BoxShape.rectangle,
                            ),
                            todayHighlightColor: Colors.amber,
                          ),
                        ),
                      ),
                    ),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Material(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.5,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      color: Colors.grey.shade200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
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
                                  dashboardController.selectedThematique = null;
                                },
                              ),
                              IconButton(
                                  padding: const EdgeInsets.fromLTRB(
                                      5, 0, 5, 0),
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      final List<UserTask> meetings = <
                                          UserTask>[];
                                      //if (widget.selectedAppointment != null) dashboardController.deleteTask(selectedAppointment.id);
                                      if (dashboardController.subject == null) {
                                        showDialog(context: context,
                                            builder: ((context) {
                                              return AlertDialog(
                                                  content: Row(
                                                    children: const [
                                                      Icon(Icons
                                                          .dangerous_outlined,
                                                        color: Colors.red,),
                                                      Text(
                                                          'Choississez un sujet'),
                                                    ],
                                                  )
                                              );
                                            }));
                                      }
                                      if (dashboardController
                                          .selectedAppointment !=
                                          null) {
                                        dashboardController.events!
                                            .appointments!
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
                                        dashboardController
                                            .loginController.currentUser.id
                                            .toString(),
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
                                          isAllDay: dashboardController
                                              .isAllDay,
                                          subject: dashboardController
                                              .subject == ''
                                              ? '(No title)'
                                              : dashboardController.subject,
                                          color: dashboardController.color,
                                          //resourceIds: dashboardController.user.id,
                                        ),
                                      );

                                      dashboardController.events!.appointments!
                                          .add(meetings[0]);
                                      dashboardController.events!
                                          .notifyListeners(
                                          CalendarDataSourceAction.add,
                                          meetings);
                                      dashboardController.selectedAppointment =
                                      null;

                                      Navigator.pop(context);
                                      setState(() {
                                        dashboardController.fetchUserTasks();
                                        dashboardController.subject = null;
                                        dashboardController.selectedThematique = null;
                                      });
                                    }

                                    );
                                  }),
                            ],
                          ),
                          Material(
                            child: ListTile(
                              tileColor: Colors.white,
                              hoverColor: Colors.white,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  5, 2, 5, 2),
                              leading: const Icon(
                                Icons.public,
                                color: Colors.black,
                              ),
                              title: GetBuilder<DashBoardCalendarController>(
                                  builder: (logic) {
                                    return dashboardController.subject != null
                                        ? Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        const Text('SUJET'),
                                        Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: dashboardController
                                                  .getTaskCardColor(
                                                  dashboardController.subject!),
                                              borderRadius: BorderRadius
                                                  .circular(8),
                                            ),
                                            child: Text(
                                              '${dashboardController.subject}',
                                              style: const TextStyle(
                                                  color: Colors.white),))
                                      ],
                                    )
                                        : const Text('SUJET');
                                  }),
                              onTap: () {
                                showDialog<Widget>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Container(
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.5,
                                        height:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.5,
                                        child: ListView.builder(
                                          itemCount: dashboardController
                                              .projectsServicesNames.length,
                                          /*itemCount: UserTaskSubject.values
                                              .length,*/
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: Icon(
                                                Icons.lens,
                                                color: dashboardController
                                                    .getTaskCardColor(
                                                    dashboardController
                                                        .projectsServicesNames[
                                                    index]),
                                                /*getUserTaskPickerLensColor(
                                                      UserTaskSubject
                                                          .values[index]),*/
                                              ),
                                              title: Text(
                                                dashboardController
                                                    .projectsServicesNames[index],
                                                /*getSubjectTaskToString(
                                                    UserTaskSubject
                                                        .values[index]),*/
                                                //UserTaskSubject.values[index].name.toString(),
                                                /*UserTaskSubject.values[index].name
                                                      .toString()*/
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  dashboardController.subject =
                                                  dashboardController.projectsServicesNames[index];
                                                  /*getSubjectTaskToString(
                                                          UserTaskSubject
                                                              .values[index]);*/
                                                  /*UserTaskSubject.values[index].name
                                                      .toString();*/
                                                  dashboardController.color =
                                                      dashboardController.getTaskCardColor(dashboardController.subject!);
                                                  dashboardController.update();
                                                });
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 200),
                                                        () {
                                                      // When task is over, close the dialog
                                                      Navigator.pop(context);
                                                      if(dashboardController.subject == dashboardController.projectsServicesNames[0]) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: Text('Choississez une thématique'),
                                                                content: GetBuilder<DashBoardCalendarController>(builder: (logic) {
                                                                  return DropdownButton<String>(
                                                                    hint: logic.selectedThematique == null
                                                                        ? Text('Thématique')
                                                                        : Text('${logic.selectedThematique}'),
                                                                    value: logic.selectedThematique,
                                                                    items: logic.themeNames!.map((item) => DropdownMenuItem<String>(
                                                                              value: item,
                                                                              child: Text(
                                                                                item,
                                                                                style: GoogleFonts.acme(
                                                                                    color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                    ).toList(),
                                                                    onChanged: (value) {
                                                                      logic.selectedThematique = value;
                                                                      logic.update();
                                                                      Get.back();
                                                                    },
                                                                  );
                                                                }),
                                                              );
                                                            },
                                                        );
                                                      }
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
                                    dashboardController.update();
                                    //dashboardController.color = getTaskCardColor(dashboardController.subject);
                                  });
                                });
                              },
                            ),
                          ),
                          /*dashboardController.subject == 'Audit RGAA'
                              ? GetBuilder<BaseController>(builder: (logic) {
                            return DropdownButton<String>(
                              hint: Text('Thématique'),
                              items: logic.projectsNames
                                  .map(
                                      (item) =>
                                      DropdownMenuItem<
                                          String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: GoogleFonts.acme(
                                              color: Colors
                                                  .black),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                dashboardController.update();
                              },
                            );
                          })
                              : SizedBox(),*/
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
                                            dashboardController.isAllDay =
                                                value;
                                            dashboardController.update();
                                          });
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 1.0,
                            thickness: 1,
                          ),
                          GetBuilder<DashBoardCalendarController>(
                            builder: (logic) {
                              return dashboardController.isAllDay == false
                                  ? Column(
                                children: [
                                  Material(
                                    child: ListTile(
                                        contentPadding: const EdgeInsets
                                            .fromLTRB(5, 2, 5, 2),
                                        leading: const Text(''),
                                        title: Row(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 7,
                                                child: Material(
                                                  child: GestureDetector(
                                                      child: GetBuilder<
                                                          DashBoardCalendarController>(
                                                          builder: (logic) {
                                                            return Text(
                                                                DateFormat(
                                                                    'EEE, MMM dd yyyy',
                                                                    'fr')
                                                                    .format(
                                                                    dashboardController
                                                                        .startDate!),
                                                                textAlign: TextAlign
                                                                    .left,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black));
                                                          }),
                                                      onTap: () async {
                                                        final DateTime? date =
                                                        await showDatePicker(
                                                          locale: const Locale(
                                                              'fr'),
                                                          context: context,
                                                          initialDate:
                                                          dashboardController
                                                              .startDate!,
                                                          firstDate: DateTime(
                                                              1900),
                                                          lastDate: DateTime(
                                                              2100),
                                                        );

                                                        if (date != null &&
                                                            date !=
                                                                dashboardController
                                                                    .startDate) {
                                                          setState(() {
                                                            /*final Duration difference =
                                                            dashboardController
                                                                .endDate!
                                                                .difference(
                                                                dashboardController
                                                                    .startDate!);*/
                                                            dashboardController
                                                                .startDate =
                                                                DateTime(
                                                                    date.year,
                                                                    date.month,
                                                                    date.day,
                                                                    dashboardController
                                                                        .startTime!
                                                                        .hour,
                                                                    dashboardController
                                                                        .startTime!
                                                                        .minute,
                                                                    0);
                                                            dashboardController
                                                                .endDate =
                                                                dashboardController
                                                                    .startDate;
                                                            /*dashboardController
                                                                .endDate =
                                                                dashboardController
                                                                    .startDate!
                                                                    .add(
                                                                    difference);*/
                                                            dashboardController
                                                                .endTime =
                                                                TimeOfDay(
                                                                    hour: dashboardController
                                                                        .endDate!
                                                                        .hour,
                                                                    minute:
                                                                    dashboardController
                                                                        .endDate!
                                                                        .minute);
                                                            dashboardController
                                                                .update();
                                                          });
                                                        }
                                                      }),
                                                ),
                                              ),

                                            ])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Expanded(
                                          child: GetBuilder<
                                              DashBoardCalendarController>(
                                              builder: (logic) {
                                                return GestureDetector(
                                                    child: Container(
                                                      color: Colors.white,
                                                      padding: const EdgeInsets
                                                          .all(10),
                                                      margin: EdgeInsets.all(5),
                                                      child: Center(
                                                        child: Text(
                                                          DateFormat(
                                                              'Hm', ('fr'))
                                                              .format(
                                                              dashboardController
                                                                  .startDate!),
                                                          textAlign: TextAlign
                                                              .right,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                      ),
                                                    ),
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
                                                          dashboardController
                                                              .endDate!
                                                              .difference(
                                                              dashboardController
                                                                  .startDate!);
                                                          dashboardController
                                                              .startDate =
                                                              DateTime(
                                                                  dashboardController
                                                                      .startDate!
                                                                      .year,
                                                                  dashboardController
                                                                      .startDate!
                                                                      .month,
                                                                  dashboardController
                                                                      .startDate!
                                                                      .day,
                                                                  dashboardController
                                                                      .startTime!
                                                                      .hour,
                                                                  dashboardController
                                                                      .startTime!
                                                                      .minute,
                                                                  0);
                                                          dashboardController
                                                              .endDate =
                                                              dashboardController
                                                                  .startDate!
                                                                  .add(
                                                                  difference);
                                                          dashboardController
                                                              .endTime =
                                                              TimeOfDay(
                                                                  hour:
                                                                  dashboardController
                                                                      .endDate!
                                                                      .hour,
                                                                  minute:
                                                                  dashboardController
                                                                      .endDate!
                                                                      .minute);
                                                        });
                                                        dashboardController
                                                            .update();
                                                      }
                                                    });
                                              }),
                                        ),
                                        Expanded(
                                          child: GetBuilder<
                                              DashBoardCalendarController>(
                                              builder: (logic) {
                                                return GestureDetector(
                                                  child: Container(
                                                    color: Colors.white,
                                                    padding: const EdgeInsets
                                                        .all(10),
                                                    margin: EdgeInsets.all(5),
                                                    child: Center(
                                                      child: Text(
                                                        DateFormat('Hm', 'fr')
                                                            .format(
                                                            dashboardController
                                                                .endDate!),
                                                        textAlign: TextAlign
                                                            .right,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .black),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    final TimeOfDay? time =
                                                    await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay(
                                                            hour: dashboardController
                                                                .endTime!.hour,
                                                            minute: dashboardController
                                                                .endTime!
                                                                .minute));

                                                    if (time != null &&
                                                        time !=
                                                            dashboardController
                                                                .endTime) {
                                                      setState(
                                                            () {
                                                          dashboardController
                                                              .endTime =
                                                              time;
                                                          final Duration difference =
                                                          dashboardController
                                                              .endDate!
                                                              .difference(
                                                              dashboardController
                                                                  .startDate!);
                                                          dashboardController
                                                              .endDate =
                                                              DateTime(
                                                                  dashboardController
                                                                      .endDate!
                                                                      .year,
                                                                  dashboardController
                                                                      .endDate!
                                                                      .month,
                                                                  dashboardController
                                                                      .endDate!
                                                                      .day,
                                                                  dashboardController
                                                                      .endTime!
                                                                      .hour,
                                                                  dashboardController
                                                                      .endTime!
                                                                      .minute,
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
                                                        },
                                                      );
                                                      dashboardController
                                                          .update();
                                                    }
                                                  },
                                                );
                                              }),

                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ) : SizedBox();
                            },
                          ),
                          //dashboardController.isAllDay == false
                          /*? Material(
                        child: ListTile(
                            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                            leading: const Text(''),
                            title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 7,
                                    child: Material(
                                      child: GestureDetector(
                                          child: Text(
                                              DateFormat('EEE, MMM dd yyyy', 'fr')
                                                  .format(dashboardController
                                                      .startDate!),
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
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
                                                dashboardController.startDate =
                                                    DateTime(
                                                        date.year,
                                                        date.month,
                                                        date.day,
                                                        dashboardController
                                                            .startTime!.hour,
                                                        dashboardController
                                                            .startTime!.minute,
                                                        0);
                                                dashboardController.endDate =
                                                    dashboardController.startDate!
                                                        .add(difference);
                                                dashboardController.endTime =
                                                    TimeOfDay(
                                                        hour: dashboardController
                                                            .endDate!.hour,
                                                        minute:
                                                            dashboardController
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
                                                        .startTime = time;
                                                    final Duration difference =
                                                        dashboardController
                                                            .endDate!
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
                                                                    .endDate!
                                                                    .hour,
                                                            minute:
                                                                dashboardController
                                                                    .endDate!
                                                                    .minute);
                                                  });
                                                }
                                              })),
                                ])),
                      ) : SizedBox(),*/
                          /*Material(
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
                                            .format(dashboardController.endDate!),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(color: Colors.black)),
                                    onTap: () async {
                                      final DateTime? date = await showDatePicker(
                                        locale: const Locale('fr'),
                                        context: context,
                                        initialDate: dashboardController.endDate!,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );

                                      if (date != null &&
                                          date != dashboardController.endDate) {
                                        setState(() {
                                          final Duration difference =
                                              dashboardController.endDate!
                                                  .difference(dashboardController
                                                      .startDate!);
                                          dashboardController.endDate = DateTime(
                                              date.year,
                                              date.month,
                                              date.day,
                                              dashboardController.endTime!.hour,
                                              dashboardController.endTime!.minute,
                                              0);
                                          if (dashboardController.endDate!
                                              .isBefore(dashboardController
                                                  .startDate!)) {
                                            dashboardController.startDate =
                                                dashboardController.endDate!
                                                    .subtract(difference);
                                            dashboardController.startTime =
                                                TimeOfDay(
                                                    hour:
                                                        dashboardController
                                                            .startDate!.hour,
                                                    minute: dashboardController
                                                        .startDate!.minute);
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
                                                dashboardController.endDate!),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                color: Colors.black)),
                                        onTap: () async {
                                          final TimeOfDay? time =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay(
                                                      hour: dashboardController
                                                          .endTime!.hour,
                                                      minute: dashboardController
                                                          .endTime!.minute));

                                          if (time != null &&
                                              time !=
                                                  dashboardController.endTime) {
                                            setState(
                                              () {
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
                                                if (dashboardController.endDate!
                                                    .isBefore(dashboardController
                                                        .startDate!)) {
                                                  dashboardController.startDate =
                                                      dashboardController.endDate!
                                                          .subtract(difference);
                                                  dashboardController.startTime =
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
                                              },
                                            );
                                          }
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),*/
                          const Divider(
                            height: 1.0,
                            thickness: 1,
                          ),
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
              ),
        );
      },
    );
  }
}
