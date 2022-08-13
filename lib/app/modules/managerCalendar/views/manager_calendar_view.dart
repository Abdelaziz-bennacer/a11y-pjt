/*library event_calendar;

import 'dart:math';
import 'package:a11y_pjt/app/data/providers/user_provider.dart';
import 'package:a11y_pjt/app/modules/adminCalendar/controllers/admin_calendar_controller.dart';
import 'package:a11y_pjt/app/modules/adminUsers/controllers/admin_users_controller.dart';
import 'package:a11y_pjt/app/modules/managerCalendar/controllers/manager_calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../config/app_information.dart';
import '../../../data/models/user_resources/user_resources.dart';

part 'color-picker.dart';

//part 'timezone-picker.dart';

part 'appointment-editor.dart';

//part 'resource-picker.dart';



//ignore: must_be_immutable
class EventCalendar extends StatefulWidget {


  @override
  EventCalendarState createState() => EventCalendarState();
}

*//*List<Color>? _colorCollection;
List<String>? _colorNames;
int _selectedColorIndex = 0;
int _selectedTimeZoneIndex = 0;
int _selectedResourceIndex = 0;
List<String>? _timeZoneCollection;
DataSource? _events;
Meeting? _selectedAppointment;
DateTime? _startDate;
TimeOfDay? _startTime;
DateTime? _endDate;
TimeOfDay? _endTime;
bool? _isAllDay;
String _subject = '';
String _notes = '';
List<CalendarResource>? _employeeCollection;
List<String>? _nameCollection;

final userProvider = Get.put(UserProvider());
final adminCalendarController = Get.put(AdminCalendarController());*//*

class EventCalendarState extends State<EventCalendar> {
  final managerCalendarController = Get.find<ManagerCalendarController>();
  //EventCalendarState();
  *//*Future<List<Meeting>> localData() async {
    var list = await adminCalendarController.fetchManagerTasks2();
    return list;
  }*//*
  //List<String>? _eventNameCollection;
  *//*@override
  void initState() {
    _addResourceDetails();
    _employeeCollection = <CalendarResource>[];
    //_addResources();
    //_events = DataSource(getMeetingDetails(),_employeeCollection!);
    //var localData = await adminCalendarController.fetchManagerTasks2();
    _events = DataSource(localData, _employeeCollection!);
    _selectedAppointment = null;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _selectedResourceIndex = 0;
    _subject = '';
    _notes = '';
    super.initState();
  }*//*

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        //resizeToAvoidBottomPadding: false,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: SafeArea(
                child: SfCalendar(
                  view: CalendarView.timelineDay,
                  allowedViews: const <CalendarView>[
                    CalendarView.timelineDay,
                    CalendarView.timelineWeek,
                    CalendarView.timelineWorkWeek,
                    CalendarView.timelineMonth
                  ],
                  dataSource: managerCalendarController.events,
                  onTap: onCalendarTapped,
                  monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),
                ))));
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    managerCalendarController.selectedAppointment = null;
    managerCalendarController.isAllDay = false;
    managerCalendarController.selectedColorIndex = 0;
    //managerCalendarController.selectedTimeZoneIndex = 0;
    managerCalendarController.selectedResourceIndex = 0;
    managerCalendarController.subject = '';
    managerCalendarController.notes = '';

    if (calendarTapDetails.appointments != null &&
        calendarTapDetails.appointments!.length == 1) {
      final Meeting meetingDetails = calendarTapDetails.appointments![0];
      managerCalendarController.startDate = meetingDetails.startTime;
      managerCalendarController.endDate = meetingDetails.endTime;
      managerCalendarController.isAllDay = meetingDetails.isAllDay;
      managerCalendarController.selectedColorIndex = managerCalendarController.colorCollection.indexOf(meetingDetails.color!);
      *//*_selectedTimeZoneIndex = meetingDetails.startTimeZone == ''
          ? 0
          : _timeZoneCollection!.indexOf(meetingDetails.startTimeZone);*//*
      managerCalendarController.subject = meetingDetails.subject == '(No title)'
          ? ''
          : meetingDetails.subject!;
      managerCalendarController.notes = meetingDetails.notes!;
      *//*managerCalendarController.selectedResourceIndex =
          managerCalendarController.nameCollection!.indexOf(calendarTapDetails.resource!.displayName);*//*
      managerCalendarController.selectedAppointment = meetingDetails;
    } else {
      final DateTime? date = calendarTapDetails.date;
      managerCalendarController.startDate = date;
      managerCalendarController.endDate = date!.add(const Duration(hours: 1));
    }
    managerCalendarController.startTime = TimeOfDay(hour: managerCalendarController.startDate!.hour, minute: managerCalendarController.startDate!.minute);
    managerCalendarController.endTime = TimeOfDay(hour: managerCalendarController.endDate!.hour, minute: managerCalendarController.endDate!.minute);
    Navigator.push<Widget>(
      context,
      MaterialPageRoute(builder: (BuildContext context) => AppointmentEditor()),
    );
  }

}

class DataSource extends CalendarDataSource {
  DataSource(List<Meeting> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;

  @override
  String getSubject(int index) => appointments![index].subject;

  *//*@override
  String getStartTimeZone(int index) => appointments![index].startTimeZone;*//*

  @override
  String getNotes(int index) => appointments![index].notes;

  *//*@override
  String getEndTimeZone(int index) => appointments![index].endTimeZone;*//*

  @override
  Color getColor(int index) => appointments![index].color;

  @override
  DateTime getStartTime(int index) => appointments![index].startTime;

  @override
  DateTime getEndTime(int index) => appointments![index].endTime;

  @override
  List<String> getResourceIds(int index) {
    return appointments![index].resourcesIds;
  }
}

class Meeting {
  Meeting(
      {required this.startTime,
        required this.endTime,
        this.color,
        this.isAllDay = false,
        this.subject = '',
        //this.startTimeZone = '',
        //this.endTimeZone = '',
        this.notes = '',
        this.resourcesIds});

  final String? subject;
  final DateTime? startTime;
  final DateTime? endTime;
  final Color? color;
  final bool? isAllDay;
  //final String startTimeZone;
  //final String endTimeZone;
  final String? notes;
  final List<String>? resourcesIds;
}*/
