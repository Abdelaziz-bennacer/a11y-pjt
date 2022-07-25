import 'dart:ui';
import 'package:flutter/material.dart';

class UserTask {
  String? id;
  String? subject;
  DateTime? startTime;
  DateTime? endTime;
  bool? isAllDay;
  String? notes;
  String? resourceIds;
  Color? color;

  UserTask({
    this.id,
    this.startTime,
    this.endTime,
    this.isAllDay = false,
    this.subject = '',
    this.notes = '',
    this.resourceIds,
    this.color,
  });

  @override
  String toString() {
    return 'UserTask{uid: $id, subject: $subject, startTime: $startTime, endTime: $endTime, isAllDay: $isAllDay, notes: $notes, color: $color, resourceIds: $resourceIds}'; //resourceIds: $resourceIds}';
  }

  /*List<int> resourceIdsToList() {
    List<int>? resources = [resourceIds!];
    return resources;
  }*/

  factory UserTask.fromJson(Map<String, dynamic> json) => UserTask(
    id: json["uid"],
    subject: json["subject"],
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
    isAllDay: json["isAllDay"],
    resourceIds: json["resourceIds"],
    notes: json["notes"],
    //color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    //"uid": id,
    "subject": subject,
    "startTime": startTime!.toIso8601String(),
    "endTime": endTime!.toIso8601String(),
    "isAllDay": isAllDay,
    "resourceIds": resourceIds,
    "notes": notes,
    //"color": color,
  };
}