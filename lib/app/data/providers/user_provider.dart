import 'dart:convert';

import 'package:a11y_pjt/app/data/errors/error_handler.dart';
import 'package:a11y_pjt/app/modules/base/views/components/dash_board_calendar/usertask_subject_picker.dart';
import 'package:a11y_pjt/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_information.dart';
import '../../global/ui/utils/dialog_util.dart';
import '../../modules/adminCalendar/controllers/admin_calendar_controller.dart';
import '../models/user_resources/user_resources.dart';
import '../models/usertask_model/usertask_model.dart';
import 'network_handler.dart';


class UserProvider extends GetxService with ErrorHandler{
  final String uploadPictureEndPoint = AppConstants.uploadPictureEndPoint;
  final String dbBaseUrl = AppConstants.dbBaseUrl;

  Future<List<UserResources>> getUsers() async {
    final response = await NetworkHandler.get('/api/users?populate=*').catchError(handleError);
    print('RESPONSE: $response');

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      throw Error();
    } else {
      //print('GET CURRENT USER: $response');
      final List<UserResources> users = [];
      for (var data in response) {
        var user = UserResources.fromJson(data);
        /*UserResources user = UserResources(
          id: data['id'].toString(),
          name: data['username'],
          imageAvatar: data["avatar"][0]["formats"]["small"]["url"]
          //firstName: data['firstName'],
          //email: data['email'],
          //fonction: data['fonction'],
        );*/
        users.add(user);
    }
      return users;
  }
  }

  Future getCurrentUser(int id) async {
    var response = await NetworkHandler.get(
      '/api/users/$id?populate=*',
      //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTYsImlhdCI6MTY1NDQ2NTU1NSwiZXhwIjoxNjU3MDU3NTU1fQ.Sn0o-FqU_2KXB1KtL15lOdnqM8yzY7q3ZUFRsTE4Pug',
      //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjU0NjMwMDE3LCJleHAiOjE2NTcyMjIwMTd9.tepa8jatmTi9o51ZE0bidtDpj1wL2nmMJ0USDukFoqc',
    ).catchError(handleError);

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      return;
    } else {
      //print('GET CURRENT USER: $response');
      return response;
    }
  }

  Future<List<TasksForManagerCalendar>> getAllTasks() async {
    var response = await NetworkHandler.get("/api/usertasks").catchError(handleError);
    //print('JSONDATA:  $jsonData');
    print('DATA: $response');
    List<dynamic> dataX = response['data'];



    final List<TasksForManagerCalendar> appointmentData = [];
    //Future.forEach((task, ) =>);
    var i = 0;
    for(i; i<dataX.length;i++) {
      TasksForManagerCalendar meetingData = TasksForManagerCalendar(
        id: dataX[i]['id'].toString(),//task['id'].toString(),
        subject: dataX[i]['attributes']['subject'],//task['attributes']['subject'],
        startTime: DateTime.parse(dataX[i]['attributes']['startTime']),//DateTime.parse(task['attributes']["startTime"]),
        endTime: DateTime.parse(dataX[i]['attributes']['endTime']),//DateTime.parse(task['attributes']['endTime']),
        color: dataX[i]['attributes']['color'] != null
            ? getTaskCardColor(dataX[i]['data']['attributes']['color'])
            : Colors.pink,
        isAllDay: dataX[i]['attributes']['isAllDay'],//task['attributes']['isAllDay'],
        resourceIds: <String>[dataX[i]['attributes']['resourceIds']],//task['attributes']["resourcesIds"],
      );
      appointmentData.add(meetingData);
    }
    /*for (var task in dataX) {
      TasksForManagerCalendar meetingData = TasksForManagerCalendar(
        id: task['data']['id'].toString(),//task['id'].toString(),
        subject: task['data']['attributes']['subject'],//task['attributes']['subject'],
        startTime: DateTime.parse(task['data']['attributes']['startTime']),//DateTime.parse(task['attributes']["startTime"]),
        endTime: DateTime.parse(task['data']['attributes']['endTime']),//DateTime.parse(task['attributes']['endTime']),
        color: task['data']['attributes']['color'] != null
            ? getTaskCardColor(task['data']['attributes']['color'])
            : Colors.pink,
        isAllDay: task['data']['attributes']['isAllDay'],//task['attributes']['isAllDay'],
        resourceIds: <String>[task['data']['attributes']['resourceIds']],//task['attributes']["resourcesIds"],
      );
      appointmentData.add(meetingData);
    }*/
    print('APPOINTMENT: $appointmentData');
    return appointmentData;
  }

  Future<List<UserTask>> getDataFromWeb(int id) async {
    var data = await NetworkHandler.get('/api/usertasksbyuser/$id');
    final List<UserTask> appointmentData = [];
    //Future.forEach((task, ) =>);
    for (var task in data) {
      UserTask meetingData = UserTask(
        id: task['uid'],
        subject: task['subject'],
        startTime: DateTime.parse(task["startTime"]),
        endTime: DateTime.parse(task['endTime']),
        color: getTaskCardColor(task['subject']),
        isAllDay: task['isAllDay'],
        resourceIds: task["resourcesIds"],
      );
      appointmentData.add(meetingData);
    }
    return appointmentData;
  }

  Future postNewTask(String subject, DateTime startTime, DateTime endTime,
      bool isAllDay, String resourceIds, String? notes) async {
    final response = await NetworkHandler.post(
      {
        'data': {
          "subject": subject,
          "startTime": startTime.toIso8601String(),
          "endTime": endTime.toIso8601String(),
          "isAllDay": isAllDay,
          "resourceIds": resourceIds,
          //"resourceIds": resourceIds,
          "notes": notes,
          //"color": color
        }
      },
      '/api/usertasks',
    );
    print(response);
  }

  Future postNewTaskByManager(
      String subject,
      DateTime startTime,
      DateTime endTime,
      bool isAllDay,
      String resourceIds,
      String? notes,
      //Color? color
      ) {
    final response = NetworkHandler.post(
      {
        "data": {
          "subject": subject,
          "startTime": startTime.toIso8601String(),
          "endTime": endTime.toIso8601String(),
          "isAllDay": isAllDay,
          "resourceIds": resourceIds,
          "notes": notes,
          //"color": color
        }
      },
      '/api/usertasks',
        //"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjUwNjU1OTM3LCJleHAiOjE2NTMyNDc5Mzd9.NF98IRSw2t0RSgXdoQ2cvdVAbGWjADXHhIFR_MH3LMo"
    );

    return response;
  }
}