import 'dart:ui';

import 'package:a11y_pjt/app/modules/managerCalendar/views/manager_calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../config/app_information.dart';
import '../../../data/models/user_resources/user_resources.dart';
import '../../../data/providers/user_provider.dart';
import '../../adminCalendar/controllers/admin_calendar_controller.dart';

class ManagerCalendarController extends GetxController {

  //List<Color>? colorCollection;
  //List<String>? colorNames;
  int selectedColorIndex = 0;
  //int selectedTimeZoneIndex = 0;
  int selectedResourceIndex = 0;
  //List<String>? timeZoneCollection;
  DataSource? events;
  Meeting? selectedAppointment;
  DateTime? startDate;
  TimeOfDay? startTime;
  DateTime? endDate;
  TimeOfDay? endTime;
  bool? isAllDay;
  String subject = '';
  String notes = '';
  List<CalendarResource>? employeeCollection;
  //List<String>? nameCollection;

  final userProvider = Get.put(UserProvider());
  final adminCalendarController = Get.put(AdminCalendarController());

  List<Color> colorCollection = <Color>[
  const Color(0xFF0F8644),
  const Color(0xFF8B1FA9),
  const Color(0xFFD20100),
  const Color(0xFFFC571D),
  const Color(0xFF85461E),
  const Color(0xFFFF00FF),
  const Color(0xFF3D4FB5),
  const Color(0xFFE47C73),
  const Color(0xFF636363),
  ];


  @override
  void onInit() async{
    _addResourceDetails();
    employeeCollection = <CalendarResource>[];
    //_addResources();
    //_events = DataSource(getMeetingDetails(),_employeeCollection!);
    //var localData = await fetchManagerTasks2();
    //events = DataSource(localData, employeeCollection!);
    selectedAppointment = null;
    //selectedColorIndex = 0;
    //selectedTimeZoneIndex = 0;
    selectedResourceIndex = 0;
    subject = '';
    notes = '';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<String> stringToListString(String resourceIds) {
    List<String> toString = [resourceIds];
    return toString;
  }

  /*Future<List<Meeting>> fetchManagerTasks() async {
    var response = await userProvider.getAllTasks();
    List<Meeting> list = [];
    for (var task in response) {
      list.add(Meeting(
        //id: task.id,
        subject: task.subject,
        startTime: task.startTime,
        endTime: task.endTime,
        isAllDay: task.isAllDay,
        notes: task.notes,
        resourcesIds: stringToListString(task.resourceIds!),
        color: task.color,
      ));
    }
    //print('LIST : $list');
    return list;
  }*/
  /*Future<List<Meeting>> fetchManagerTasks2() async {
    var response = await userProvider.getAllTasks();
    List<Meeting> list = [];
    for (var task in response) {
      list.add(Meeting(
        //id: task.id,
        subject: task.subject,
        startTime: task.startTime,
        endTime: task.endTime,
        isAllDay: task.isAllDay,
        notes: task.notes,
        resourcesIds: stringToListString(task.resourceIds!),
        color: task.color,
      ));
    }
    print('LIST : $list');
    return list;
  }*/

  void _addResourceDetails() async {
    List<UserResources> response = await userProvider.getUsers();
    //users = response.cast<UserResources>();
    for (var user in response) {
      employeeCollection!.add(
        CalendarResource(
          id: user.id!,
          displayName: user.name!,
          /*image: NetworkImage(
              user.imageAvatar != null
                  ? user.imageAvatar!
                  : 'https://cdn.pixabay.com/photo/2022/06/18/16/55/cute-7270285_960_720.png',
          )*/
          /*image: ExactAssetImage(
              userImages[Random().nextInt(5)],
          ), */
          image: NetworkImage(
            user.imageAvatar != null
                ? '${AppConstants.dbBaseUrl}${user.imageAvatar!}'
                : 'https://cdn.pixabay.com/photo/2022/06/18/16/55/cute-7270285_960_720.png',

          ),
        ),
      );
    }
    //return _employeeCollection!;
  }

}
