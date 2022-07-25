import 'package:a11y_pjt/app/data/providers/user_provider.dart';
import 'package:a11y_pjt/app/modules/base/views/components/dash_board_calendar/user_calendar_datasource.dart';
import 'package:a11y_pjt/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../../data/models/usertask_model/usertask_model.dart';

class DashBoardCalendarController extends GetxController {
  final userProvider = Get.put(UserProvider());
  final loginController = Get.find<LoginController>();
  //final homeController = Get.find<HomeController>();

  //User user = User();

  List<Appointment>? tasks;
  UserTask? selectedAppointment;
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
  int? colorToDB;

  UserCalendarDataSource? events;

  List<String>? eventNameCollection;

  List<UserTask> allUserTasks = [];
  List<UserTask> todayTasks = [];

  @override
  void onInit() async {
    super.onInit();
    var localData = await fetchUserTasks();
    //displayTodayTasks();
    print("init");
    events = UserCalendarDataSource(localData);
  }

  displayTodayTasks() {
    for (var task in allUserTasks) {
      UserTask newTask = UserTask(
        //id: task.id,
        subject: task.subject,
        //notes: task.notes,
        startTime: task.startTime,
      );
      if (newTask.startTime == DateTime.now()) {
        todayTasks.add(newTask);
      }
    }
    /*todayTasks = allUserTasks
        .where((element) =>
            element.startTime == DateTime.now().add(Duration(days: 1)))
        .toList();*/
    //print('TODAY:  $todayTasks');
    return todayTasks;
  }

  DateTime convertDateFromString(String date) {
    return DateTime.parse(date);
  }

  Future addNewTask(String? subject, DateTime? startTime, DateTime? endTime,
      bool? isAllDay, String? resourceIds, String? notes) async {
    await userProvider.postNewTask(
        subject!, startTime!, endTime!, isAllDay!, resourceIds!, notes);
  }

  Future<List<UserTask>> fetchUserTasks() async {
    final response = await userProvider.getDataFromWeb(loginController.currentUser.id);
    allUserTasks = response;
    //print(allUserTasks);
    return response;
  }

/*Future<List<UserTask>> fetchManagerTasks() async {
    final response = await userProvider.getAllTasks();
    return response;
  }*/

}
