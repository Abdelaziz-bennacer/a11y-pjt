import 'package:flutter/material.dart';

enum UserTaskSubject {
  AuditRGAA,
  AuditRAAM,
  Reunion,
  DeplacementClient,
  AdminGDP,
  PrepaProjet,
}

const kGreen = 0xFF0F8644;
const kPurple = 0xFF8B1FA9;
const kRed = 0xFFD20100;
const kBlue = 0xFF3D4FB5;
const kPink = 0xFFFF00FF;
const kOrange = 0xFFE47C73;

Color getUserTaskPickerLensColor(UserTaskSubject subject) {
  switch (subject) {
    case UserTaskSubject.AuditRGAA:
      return const Color(kGreen);
    case UserTaskSubject.AuditRAAM:
      return const Color(kPurple);
    case UserTaskSubject.Reunion:
      return const Color(kRed);
    case UserTaskSubject.DeplacementClient:
      return const Color(kBlue);
    case UserTaskSubject.AdminGDP:
      return const Color(kPink);
    case UserTaskSubject.PrepaProjet:
      return const Color(kOrange);
    default:
      return const Color(kBlue);
  }
}

Color getTaskCardColor(String subject) {
  switch (subject) {
    case "AuditRGAA":
      return const Color(kGreen);
    case "AuditRAAM":
      return const Color(kPurple);
    case "Reunion":
      return const Color(kRed);
    case "DeplacementClient":
      return const Color(kBlue);
    case "AdminGDP":
      return const Color(kPink);
    case "PrepaProjet":
      return const Color(kOrange);
    default:
      return const Color(kBlue);
  }
}

String getSubjectTaskToString(UserTaskSubject subject) {
  switch (subject) {
    case UserTaskSubject.AuditRGAA:
      return 'Audit RGAA';
    case UserTaskSubject.AuditRAAM:
      return 'Audit RAAM';
    case UserTaskSubject.Reunion:
      return 'Réunion';
    case UserTaskSubject.DeplacementClient:
      return 'Déplacement Client';
    case UserTaskSubject.AdminGDP:
      return 'Admin/GDP';
    case UserTaskSubject.PrepaProjet:
      return 'Préparation Projet';
    default:
      return 'Tâche';
  }
}

class UserTaskSubjectPicker extends StatelessWidget {
  String subject;
  VoidCallback onTap;
  int selectedSubjectIndex;
  //final VoidCallback onTap;
  UserTaskSubjectPicker(
      {Key? key,
      required this.subject,
      required this.onTap,
      required this.selectedSubjectIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: UserTaskSubject.values.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.lens,
                  color: getUserTaskPickerLensColor(
                      UserTaskSubject.values[index])),
              title: Text(
                getSubjectTaskToString(UserTaskSubject.values[index]),
                //UserTaskSubject.values[index].name.toString(),
                style: const TextStyle(color: Colors.black),
              ),
              onTap: onTap,
            );
          },
        ),
      ),
    );
  }
}