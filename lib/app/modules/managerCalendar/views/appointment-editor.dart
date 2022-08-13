/*
part of event_calendar;

class AppointmentEditor extends StatefulWidget {
  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  final managerCalendarController = Get.find<ManagerCalendarController>();

  Widget _getAppointmentEditor(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              leading: const Text(''),
              title: TextField(
                controller: TextEditingController(text: managerCalendarController.subject),
                onChanged: (String value) {
                  managerCalendarController.subject = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add title',
                ),
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: Icon(
                  Icons.access_time,
                  color: Colors.black54,
                ),
                title: Row(children: <Widget>[
                  const Expanded(
                    child: Text('All-day'),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Switch(
                            value: managerCalendarController.isAllDay!,
                            onChanged: (bool value) {
                              setState(() {
                                managerCalendarController.isAllDay = value;
                              });
                            },
                          ))),
                ])),
            ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: const Text(''),
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                            child: Text(
                                DateFormat('EEE, MMM dd yyyy')
                                    .format(managerCalendarController.startDate!),
                                textAlign: TextAlign.left),
                            onTap: () async {
                              final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: managerCalendarController.startDate!,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (date != null && date != managerCalendarController.startDate) {
                                setState(() {
                                  final Duration difference =
                                  managerCalendarController.endDate!.difference(managerCalendarController.startDate!);
                                  managerCalendarController.startDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      managerCalendarController.startTime!.hour,
                                      managerCalendarController.startTime!.minute,
                                      0);
                                  managerCalendarController.endDate = managerCalendarController.startDate!.add(difference);
                                  managerCalendarController.endTime = TimeOfDay(
                                      hour: managerCalendarController.endDate!.hour,
                                      minute: managerCalendarController.endDate!.minute);
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
                                DateFormat('hh:mm a').format(managerCalendarController.startDate!),
                                textAlign: TextAlign.right,
                              ),
                              onTap: () async {
                                final TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: managerCalendarController.startTime!.hour,
                                        minute: managerCalendarController.startTime!.minute));

                                if (time != null && time != managerCalendarController.startTime) {
                                  setState(() {
                                    managerCalendarController.startTime = time;
                                    final Duration difference =
                                    managerCalendarController.endDate!.difference(managerCalendarController.startDate!);
                                    managerCalendarController.startDate = DateTime(
                                        managerCalendarController.startDate!.year,
                                        managerCalendarController.startDate!.month,
                                        managerCalendarController.startDate!.day,
                                        managerCalendarController.startTime!.hour,
                                        managerCalendarController.startTime!.minute,
                                        0);
                                    managerCalendarController.endDate = managerCalendarController.startDate!.add(difference);
                                    managerCalendarController.endTime = TimeOfDay(
                                        hour: managerCalendarController.endDate!.hour,
                                        minute: managerCalendarController.endDate!.minute);
                                  });
                                }
                              })),
                    ])),
            ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: const Text(''),
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                            child: Text(
                              DateFormat('EEE, MMM dd yyyy').format(managerCalendarController.endDate!),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () async {
                              final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: managerCalendarController.endDate!,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (date != null && date != managerCalendarController.endDate) {
                                setState(() {
                                  final Duration difference =
                                  managerCalendarController.endDate!.difference(managerCalendarController.startDate!);
                                  managerCalendarController.endDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      managerCalendarController.endTime!.hour,
                                      managerCalendarController.endTime!.minute,
                                      0);
                                  if (managerCalendarController.endDate!.isBefore(managerCalendarController.startDate!)) {
                                    managerCalendarController.startDate = managerCalendarController.endDate!.subtract(difference);
                                    managerCalendarController.startTime = TimeOfDay(
                                        hour: managerCalendarController.startDate!.hour,
                                        minute: managerCalendarController.startDate!.minute);
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
                                DateFormat('hh:mm a').format(managerCalendarController.endDate!),
                                textAlign: TextAlign.right,
                              ),
                              onTap: () async {
                                final TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: managerCalendarController.endTime!.hour,
                                        minute: managerCalendarController.endTime!.minute));

                                if (time != null && time != managerCalendarController.endTime) {
                                  setState(() {
                                    managerCalendarController.endTime = time;
                                    final Duration difference =
                                    managerCalendarController.endDate!.difference(managerCalendarController.startDate!);
                                    managerCalendarController.endDate = DateTime(
                                        managerCalendarController.endDate!.year,
                                        managerCalendarController.endDate!.month,
                                        managerCalendarController.endDate!.day,
                                        managerCalendarController.endTime!.hour,
                                        managerCalendarController.endTime!.minute,
                                        0);
                                    if (managerCalendarController.endDate!.isBefore(managerCalendarController.startDate!)) {
                                      managerCalendarController.startDate =
                                          managerCalendarController.endDate!.subtract(difference);
                                      managerCalendarController.startTime = TimeOfDay(
                                          hour: managerCalendarController.startDate!.hour,
                                          minute: managerCalendarController.startDate!.minute);
                                    }
                                  });
                                }
                              })),
                    ])),
           */
/* ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: Icon(
                Icons.public,
                color: Colors.black87,
              ),
              title: Text(managerCalendarController.timeZoneCollection![managerCalendarController.selectedTimeZoneIndex]),
              onTap: () {
                showDialog<Widget>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return _TimeZonePicker();
                  },
                ).then((dynamic value) => setState(() {}));
              },
            ),*//*

            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: Icon(Icons.lens,
                  color: managerCalendarController.colorCollection[managerCalendarController.selectedColorIndex]),
              title: Text(
                '',
                //managerCalendarController.colorNames![managerCalendarController.selectedColorIndex],
              ),
              onTap: () {
                showDialog<Widget>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return _ColorPicker();
                  },
                ).then((dynamic value) => setState(() {}));
              },
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: Icon(Icons.person_pin),
              title: Text(
                '',
                //managerCalendarController.nameCollection![managerCalendarController.selectedResourceIndex],
              ),
              onTap: () {
                */
/*showDialog<Widget>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return _ResourcePicker();
                  },
                ).then((dynamic value) => setState(() {}));*//*

              },
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(5),
              leading: Icon(
                Icons.subject,
                color: Colors.black87,
              ),
              title: TextField(
                controller: TextEditingController(text: managerCalendarController.notes),
                onChanged: (String value) {
                  managerCalendarController.notes = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add description',
                ),
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text(getTitle()),
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    icon: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      final List<Meeting> meetings = <Meeting>[];
                      if (managerCalendarController.selectedAppointment != null) {
                        managerCalendarController.events!.appointments!.removeAt(
                            managerCalendarController.events!.appointments!.indexOf(managerCalendarController.selectedAppointment));
                        managerCalendarController.events!.notifyListeners(CalendarDataSourceAction.remove,
                            <Meeting>[]..add(managerCalendarController.selectedAppointment!));
                      }
                      meetings.add(Meeting(
                          startTime: managerCalendarController.startDate!,
                          endTime: managerCalendarController.endDate!,
                          color: managerCalendarController.colorCollection[managerCalendarController.selectedColorIndex],
                          */
/*startTimeZone: _selectedTimeZoneIndex == 0
                              ? ''
                              : _timeZoneCollection![_selectedTimeZoneIndex],
                          endTimeZone: _selectedTimeZoneIndex == 0
                              ? ''
                              : _timeZoneCollection![_selectedTimeZoneIndex],*//*

                          notes: managerCalendarController.notes,
                          isAllDay: managerCalendarController.isAllDay!,
                          subject: managerCalendarController.subject == '' ? '(No title)' : managerCalendarController.subject,
                          resourcesIds: <String>['${managerCalendarController.employeeCollection![managerCalendarController.selectedResourceIndex].id}']
                      ));

                      managerCalendarController.events!.appointments!.add(meetings[0]);

                      managerCalendarController.events!.notifyListeners(
                          CalendarDataSourceAction.add, meetings);
                      managerCalendarController.selectedAppointment = null;

                      Navigator.pop(context);
                    })
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Stack(
                children: <Widget>[_getAppointmentEditor(context)],
              ),
            ),
            floatingActionButton: managerCalendarController.selectedAppointment == null
                ? const Text('')
                : FloatingActionButton(
              onPressed: () {
                if (managerCalendarController.selectedAppointment != null) {
                  managerCalendarController.events!.appointments!.removeAt(
                      managerCalendarController.events!.appointments!.indexOf(managerCalendarController.selectedAppointment));
                  managerCalendarController.events!.notifyListeners(CalendarDataSourceAction.remove,
                      <Meeting>[]..add(managerCalendarController.selectedAppointment!));
                  managerCalendarController.selectedAppointment = null;
                  Navigator.pop(context);
                }
              },
              child:
              const Icon(Icons.delete_outline, color: Colors.white),
              backgroundColor: Colors.red,
            )));
  }

  String getTitle() {
    return managerCalendarController.subject.isEmpty ? 'New event' : 'Event details';
  }
}*/
