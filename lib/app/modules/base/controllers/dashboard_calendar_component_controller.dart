import 'package:a11y_pjt/app/data/providers/user_provider.dart';
import 'package:a11y_pjt/app/data/models/user_model/user_calendar_datasource.dart';
import 'package:a11y_pjt/app/modules/base/controllers/base_controller.dart';
import 'package:a11y_pjt/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../data/models/usertask_model/usertask_model.dart';
import '../views/components/dash_board_calendar/usertask_subject_picker.dart';

class DashBoardCalendarController extends GetxController {
  final userProvider = Get.put(UserProvider());
  final loginController = Get.find<LoginController>();
  final baseController = Get.find<BaseController>();
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
    projectsServicesNames = await getProjectsServicesNames();
    themeNames = baseController.themesNames;
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
    List<UserTask> response = await userProvider.getDataFromWeb(loginController.currentUser.id);
    List<UserTask> tasks = [];
    for (UserTask task in response) {
      task.color = getTaskCardColor(task.subject!);
      tasks.add(task);
    }
    //response.map((e) => e.color = getSubjectTaskToString2(e.subject!) as Color);
    allUserTasks = tasks;
    //print(allUserTasks);
    return tasks;
  }

  List<String> projectsServicesNames = [];
  List<Color> projectsServicesColors = [
    const Color(kGreen),
    const Color(kPurple),
    const Color(kRed),
    const Color(kBlue),
    const Color(kPink),
    const Color(kOrange),
    const Color(0xffeebd2c),
    const Color(0xffc338f1),
  ];
  getProjectsServicesNames() async{
    List<String> services = await userProvider.getServices();
    projectsServicesNames = services;
    return services;
  }

  String? selectedThematique;
  List<String>? themeNames;

  /*Color getUserTaskPickerLensColor() {
    switch (projectsServicesNames) {

    }
  }*/

  Color getTaskCardColor(String subject) {
    /*var index = 0;
    Color? color;
    for(index;index<projectsServicesNames.length;index++) {
      if(subject == projectsServicesNames[index]){color = const Color(kGreen);}
      else if(subject == projectsServicesNames[index]) {color = const Color(kGreen);}
      else if(subject == projectsServicesNames[index]) {color = const Color(kPurple);}
      else if(subject == projectsServicesNames[index]) {color = const Color(kRed);}
      else if(subject == projectsServicesNames[index]) {color = const Color(kBlue);}
      else if(subject == projectsServicesNames[index]) {color = const Color(kPink);}
      else if(subject == projectsServicesNames[index]) {color = const Color(kOrange);}
      else {return const Color(kOrange);}
    }
    return color!;*/
    //List<String> services = getProjectsServicesNames();
    //var currentServiceName = projectsServicesNames.map((service) => {service == subject}).first.toString();
    //String currentServiceName = projectsServicesNames.firstWhere((element) => element == subject);
    var currentServiceName = projectsServicesNames.firstWhere((element) => element == subject);
    var currentIndexService = projectsServicesNames.indexOf(currentServiceName);
    return projectsServicesColors[currentIndexService];
    /*int index = 0;
    for(index;index<projectsServicesNames.length;index++) {
      projectsServicesNames[0] = projectsServicesColors[0];
    }*/
    /*projectsServicesNames.map((service) => service == subject);
    if(subject == projectsServicesNames[0]){return const Color(kPurple);}
    else if(subject == projectsServicesNames[1]) {return const Color(kGreen);}
    *//*else if(subject == projectsServicesNames[2]) {return const Color(kPurple);}
    else if(subject == projectsServicesNames[3]) {return const Color(kRed);}
    else if(subject == projectsServicesNames[4]) {return const Color(kBlue);}
    else if(subject == projectsServicesNames[5]) {return const Color(kPink);}
    else if(subject == projectsServicesNames[6]) {return const Color(kOrange);}*//*
    else {return const Color(kOrange);}*/
  }

/*Future<List<UserTask>> fetchManagerTasks() async {
    final response = await userProvider.getAllTasks();
    return response;
  }*/

}
