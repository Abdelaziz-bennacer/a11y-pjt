/*Widget save() {
  return showDialog(
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
                                        *//*UserTaskSubject.values[index].name
                                                    .toString()*//*
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          dashboardController.subject =
                                              getSubjectTaskToString(
                                                  UserTaskSubject
                                                      .values[index]);
                                          *//*UserTaskSubject.values[index].name
                                                    .toString();*//*
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
                  *//*ListTile(
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
                    ),*//*
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),
                  *//*ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                        *//* *//*leading: Icon(
                      Icons.lens,
                      color: widget.colorCollection![widget.selectedColorIndex!],
                    ),*//* *//*
                        *//* *//*title: Text(
                      widget.colorNames![widget.selectedColorIndex!],
                    ),*//* *//*
                        onTap: () {
                          *//* *//*showDialog<Widget>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ColorPicker(
                            colorCollection: widget.colorCollection!,
                            selectedColorIndex: widget.selectedColorIndex!,
                            colorNames: widget.colorNames!,
                          );
                        },
                      ).then((dynamic value) => setState(() {}));*//* *//*
                        },
                      ),*//*
                  *//*const Divider(
                        height: 1.0,
                        thickness: 1,
                      ),
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
  );
}*/