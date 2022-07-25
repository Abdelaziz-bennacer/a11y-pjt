import 'dart:ui';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../data/models/usertask_model/usertask_model.dart';

class UserCalendarDataSource extends CalendarDataSource {
  UserCalendarDataSource(List<UserTask> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String? getNotes(int index) {
    return appointments![index].notes;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }

  /*@override
  Object? convertAppointmentToObject(Object? customData, Appointment appointment) {
    // TODO: implement convertAppointmentToObject
    return super.convertAppointmentToObject(customData, appointment);
  }*/

  /*@override
  List<Object>? getResourceIds(int index) {
    return appointments![index].resourceIdsToList();
  }*/
}