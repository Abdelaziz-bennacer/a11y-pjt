import 'package:a11y_pjt/app/modules/base/controllers/dashboard_calendar_component_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/*class SubjectPicker extends GetxService {
  final controller = Get.put(DashBoardCalendarController());
  Color getTaskCardColor(String subject) {
    if(subject == controller.projectsServicesNames[0]){return const Color(kGreen);}
    else if(subject == controller.projectsServicesNames[1]) {return const Color(kGreen);}
    else if(subject == controller.projectsServicesNames[2]) {return const Color(kPurple);}
    else if(subject == controller.projectsServicesNames[3]) {return const Color(kRed);}
    else if(subject == controller.projectsServicesNames[4]) {return const Color(kBlue);}
    else if(subject == controller.projectsServicesNames[5]) {return const Color(kPink);}
    else if(subject == controller.projectsServicesNames[6]) {return const Color(kOrange);}
    else {return const Color(kOrange);}
  }
}*/

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

/*Color getTaskCardColor2(String subject, List<String> subjects) {
  if(subject == subjects[0]){return const Color(kGreen);}
  else if(subject == subjects[1]) {return const Color(kGreen);}
  else if(subject == subjects[2]) {return const Color(kPurple);}
  else if(subject == subjects[3]) {return const Color(kRed);}
  else if(subject == subjects[4]) {return const Color(kBlue);}
  else if(subject == subjects[5]) {return const Color(kPink);}
  else if(subject == subjects[6]) {return const Color(kOrange);}
  else {return const Color(kOrange);}
}*/

/*Color getTaskCardColor(String subject) {
  switch (subject) {
    case "Audit RGAA":
      return const Color(kGreen);
    case "Audit RAAM":
      return const Color(kPurple);
    case "Réunion":
      return const Color(kRed);
    case "Déplacement Client":
      return const Color(kBlue);
    case "Admin/GDP":
      return const Color(kPink);
    case 'Préparation Projet':
      return const Color(kOrange);
    default:
      return Colors.amberAccent;
  }
}*/

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

String getSubjectTaskToString2(String subject) {
  switch (subject) {
    case "Audit RGAA":
      return 'Audit RGAA';
    case 'Audit RAAM':
      return 'Audit RAAM';
    case 'Réunion':
      return 'Réunion';
    case 'Déplacement Client':
      return 'Déplacement Client';
    case 'Admin/GDP':
      return 'Admin/GDP';
    case 'Préparation Projet':
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