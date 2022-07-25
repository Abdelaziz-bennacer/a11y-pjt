import 'dart:convert';
import 'dart:ui';
import 'package:a11y_pjt/app/config/app_information.dart';
import 'package:a11y_pjt/app/modules/managerCalendar/views/manager_calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../data/models/user_resources/user_resources.dart';
import '../../../data/models/usertask_model/usertask_model.dart';
import '../../../data/providers/user_provider.dart';
import '../../login/controllers/login_controller.dart';

class TasksForManagerCalendar {
  String? id;
  String? subject;
  DateTime? startTime;
  DateTime? endTime;
  bool? isAllDay;
  String? notes;
  List<String>? resourceIds;
  Color? color;

  TasksForManagerCalendar(
      {this.id,
        this.startTime,
        this.endTime,
        this.isAllDay = false,
        this.subject = '',
        this.notes = '',
        this.resourceIds,
        this.color});

  TasksForManagerCalendar.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    subject = json['subject'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isAllDay = json['isAllDay'];
    notes = json['notes'];
    resourceIds = json['resourceIds'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "startTime": startTime,
    "endTime": endTime,
    "isAllDay": isAllDay,
    "notes": notes,
    "resourceIds": resourceIds,
    "color": color,
  };

  @override
  String toString() {
    return 'UserTask{uid: $id, subject: $subject, startTime: $startTime, endTime: $endTime, isAllDay: $isAllDay, notes: $notes, color: $color, resourceIds: $resourceIds}';
  }
}

/*class ManagerCalendarDataSource extends CalendarDataSource {
  ManagerCalendarDataSource(
      List<UserTask> shiftCollection, ) {
    appointments = shiftCollection;
    resources = employeeCalendarResource.cast<CalendarResource>();
  }*/

class ManagerCalendarDataSource extends CalendarDataSource {
  ManagerCalendarDataSource(List<TasksForManagerCalendar> shiftCollection,
      List<CalendarResource> employeesResourceList) {
    appointments = shiftCollection;
    resources = employeesResourceList;
  }

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;

  @override
  String getSubject(int index) => appointments![index].subject;

  @override
  String getNotes(int index) => appointments![index].notes;

  @override
  Color getColor(int index) => appointments![index].color;

  @override
  DateTime getStartTime(int index) => appointments![index].startTime;

  @override
  DateTime getEndTime(int index) => appointments![index].endTime;

  @override
  List<String> getResourceIds(int index) {
    return appointments![index].resourceIds;
  }
}

class AdminCalendarController extends GetxController {
  final userProvider = Get.put(UserProvider());
  final loginController = Get.find<LoginController>();
  //CalendarController managerCalendarController = CalendarController();

  //late ManagerCalendarDataSource events;
  //late List<UserTask> controllerShiftCollection;

  //late List<UserResources> controllerEmployeeCalendarResource = [];
  List<CalendarResource> employeesResourceList = [];
  late List<TimeRegion> specialTimeRegion;
  List<UserResources>? users = [];

  TasksForManagerCalendar? selectedAppointment;
  bool? isAllDay = false;
  String? subject;
  String notes = '';
  DateTime? startDate;
  String? taskId;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  List<CalendarResource>? employeeCollection;
  List<String>? resourceIds = [];
  Color? color;
  ManagerCalendarDataSource? events;

  String? newTaskResourceIds;
  String? resourceName = '';

  int selectedResourceIndex = 0;
  List<TasksForManagerCalendar>? localData;

  @override
  void onInit() async {
    addResourceDetails();
    localData = await fetchManagerTasks();
    events = ManagerCalendarDataSource(localData!, employeesResourceList);
    super.onInit();
  }

  Future addNewTask(String? subject, DateTime? startTime, DateTime? endTime,
      bool? isAllDay, String resourceIds, String? notes) async {//
    await userProvider.postNewTaskByManager(
        subject!, startTime!, endTime!, isAllDay!,resourceIds, notes);//
  }

  List<String> stringToListString(String resourceIds) {
    List<String> toString = [resourceIds];
    return toString;
  }

  Future<List<TasksForManagerCalendar>> fetchManagerTasks() async {
    var response = await userProvider.getAllTasks();
    //print('ALL TASKS RESPONSE: $response');
    List<TasksForManagerCalendar> list = [];
    response.forEach((element) {list.add(element);});
    /*response.map((task) {
      TasksForManagerCalendar newTask = TasksForManagerCalendar(
        id: task.id,
        subject: task.subject,
        startTime: task.startTime,
        endTime: task.endTime,
        isAllDay: task.isAllDay,
        notes: task.notes,
        resourceIds: stringToListString(task.resourceIds!),
        color: task.color,
      );
      list.add(newTask);
    });*/

    /*for (var task in response) {
      list.add(TasksForManagerCalendar(
        id: task.id,
        subject: task.subject,
        startTime: task.startTime,
        endTime: task.endTime,
        isAllDay: task.isAllDay,
        notes: task.notes,
        resourceIds: stringToListString(task.resourceIds!),
        color: task.color,
      ));
    }*/
    print('LIST : $list');
    return list;
  }



  Future<List<CalendarResource>> addResourceDetails() async {
    var userImages = [
      'assets/images/People_Circle5.png',
      'assets/images/People_Circle8.png',
      'assets/images/People_Circle18.png',
      'assets/images/People_Circle23.png',
      'assets/images/People_Circle25.png',
      'assets/images/People_Circle20.png',
      'assets/images/People_Circle13.png',
      'assets/images/People_Circle11.png',
      'assets/images/People_Circle27.png',
      'assets/images/People_Circle26.png',
      'assets/images/People_Circle24.png',
      'assets/images/People_Circle15.png',
    ];

    List<UserResources> response = await userProvider.getUsers();
    //users = response.cast<UserResources>();
    for (var user in response) {
      employeesResourceList.add(
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
    return employeesResourceList;
  }

/*void addSpecialRegions() {
    final DateTime date = DateTime.now();
    specialTimeRegion = [
      TimeRegion(
        startTime: DateTime(date.year, date.month, date.day, 12, 0, 0),
        endTime: DateTime(date.year, date.month, date.day, 13, 0, 0),
        text: 'REPAS',
        //resourceIds: controllerEmployeeCalendarResource.map((e) => e.id).toList(),
        recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
        enablePointerInteraction: false,
      ),
    ];
  }*/
}

