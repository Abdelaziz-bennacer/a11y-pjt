import 'package:a11y_pjt/app/data/models/service_model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../../../data/models/folder_model/folder_model.dart';
import '../../../../../controllers/base_controller.dart';
import 'intern_cra_component.dart';

Column buildCRAEditor(BaseController controller) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Usage: '),
            //const SizedBox(width: 100),
            Expanded(
              child: GetBuilder<BaseController>(
                  builder: (btnCTR) {
                    return Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text(
                              'Interne (hors projets)',
                              overflow: TextOverflow.ellipsis,
                            ),
                            activeColor: Colors.blue,
                            value: 'Interne',
                            groupValue:
                            controller.selectedUsage,
                            onChanged: (String? value) {
                              controller.removeClientSelection();
                              controller.onClickUsageRadioButton(value!);
                            },
                          ),
                        ),
                        //const SizedBox(width: 200),
                        Expanded(
                          child: RadioListTile(
                            title: const Text(
                              'Client',
                              overflow: TextOverflow.ellipsis,
                            ),
                            activeColor: Colors.blue,
                            value: 'Client',
                            groupValue:
                            controller.selectedUsage,
                            onChanged: (String? value) {
                              controller
                                  .onClickUsageRadioButton(
                                  value!);
                            },
                          ),
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
      GetBuilder<BaseController>(
        builder: (ctr) {
          //List<String> items = ctr.displayCompaniesNames();
          return controller.selectedUsage == 'Interne'
              ? buildInternCraComponent(controller)
              : Container(
            child: Row(
              children: [
                GetBuilder<BaseController>(
                    builder: (logic) {
                      return DropdownButton<String>(
                        hint: Text('Client'),
                        menuMaxHeight: 400,
                        value: logic.selectedCompanyName,
                        items: logic.companiesNames
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style:
                                GoogleFonts.acme(
                                    color: Colors
                                        .black),
                              ),
                            ))
                            .toList(),
                        /*items: items.map((item) => DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item),
                                            )).toList(),*/
                        onChanged: (value) {
                          if (logic.selectedProjectName != null || logic.selectedFolderName != null || logic.selectedTheme != null) {
                            logic.selectedProjectName = null;
                            logic.selectedFolderName = null;
                            logic.selectedTheme = null;
                            controller.selectedFolder = FolderModel(uuid: '', isActif: true, projectUUID: '', name: '', service: '');
                          }
                          logic.selectedCompanyName = value;
                          logic.targetCompany();
                          logic.update();
                          //logic.displayProjectsList();
                        },
                      );
                    }),
                SizedBox(width: 25),
                GetBuilder<BaseController>(
                  builder: (logic) {
                    return DropdownButton<String>(
                      hint: Text('Projet'),
                      menuMaxHeight: 400,
                      value:
                      logic.selectedProjectName,
                      items: logic.projectsNames
                          .map(
                              (item) =>
                              DropdownMenuItem<
                                  String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.acme(
                                      color: Colors
                                          .black),
                                ),
                              ))
                          .toList(),
                      /*items: items.map((item) => DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item),
                                            )).toList(),*/
                      onChanged: (value) {
                        if (logic.selectedFolderName != null || logic.selectedTheme != null) {
                          logic.selectedFolderName = null;
                          logic.selectedTheme = null;
                        }
                        logic.selectedProjectName = value;
                        logic.targetProject();
                        logic.update();
                      },
                    );
                  },
                ),
                SizedBox(width: 25),
                GetBuilder<BaseController>(
                  builder: (logic) {
                    return DropdownButton<String>(
                      hint: Text('Dossier'),
                      menuMaxHeight: 400,
                      value: logic.selectedFolderName,
                      items: logic.foldersNames
                          .map(
                            (item) =>
                            DropdownMenuItem<
                                String>(
                              value: item,
                              child: Text(
                                item,
                                style:
                                GoogleFonts.acme(
                                    color: Colors
                                        .black),
                              ),
                            ),
                      )
                          .toList(),
                      onChanged: (value) {
                        if(logic.selectedTheme != null) {
                          logic.selectedTheme = null;
                          controller.selectedFolder = FolderModel(isActif: true, name: '', projectUUID: '', uuid: '', service: '');
                        }
                        logic.selectedFolderName = value;
                        logic.targetFolder();
                        logic.update();
                      },
                    );
                  },
                ),
                GetBuilder<BaseController>(
                  builder: (logic) {
                    return controller.selectedFolder!.service == 'Audit RGAA'
                        ? Row(
                      children: [
                        SizedBox(width: 25),
                        GetBuilder<BaseController>(
                          builder: (logic) {
                            return DropdownButton<String>(
                              hint: Text('Thématique'),
                              menuMaxHeight: 400,
                              value: logic.selectedTheme,
                              items: logic.themesNames
                                  .map(
                                    (item) =>
                                    DropdownMenuItem<
                                        String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style:
                                        GoogleFonts.acme(
                                            color: Colors
                                                .black),
                                      ),
                                    ),
                              )
                                  .toList(),
                              onChanged: (value) {
                                logic.selectedTheme =
                                    value;
                                //logic.targetFolder();
                                logic.update();
                              },
                            );
                          },
                        ),
                      ],
                    ): const SizedBox();
                  },
                ),

              ],
            ),
          );
        },
      ),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Text('Date: ',style: GoogleFonts.acme(textBaseline: TextBaseline.alphabetic,),),
                    GetBuilder<BaseController>(
                        builder: (logic) {
                          return Text(
                            DateFormat(
                                'EEEE dd MMMM yyyy', 'fr')
                                .format(logic.selectedDate)
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.acme(textBaseline: TextBaseline.alphabetic,),
                          );
                        }),
                    const SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () =>
                          controller.chooseDate(),
                      child: const Text(
                          'Sélectionner une date'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Text('Durée: ',style: GoogleFonts.acme(textBaseline: TextBaseline.alphabetic,),),
                    GetBuilder<BaseController>(
                        builder: (logic) {
                          return Row(
                            children: [
                              Text(
                                'De ${logic.selectedStartDuration!.hour}:${controller.selectedStartDuration!.minute.toString().padLeft(2, "0")}',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.acme(textBaseline: TextBaseline.alphabetic,),
                              ),
                              Text(
                                'à ${logic.selectedEndDuration!.hour}:${controller.selectedEndDuration!.minute.toString().padLeft(2, "0")}',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.acme(textBaseline: TextBaseline.alphabetic,),
                              ),
                            ],
                          );
                        }),
                    const SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () => controller.chooseDuration(),
                      child: const Text('Editer une durée'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              //margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(5),
              //height:,
              //width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1.5,
                    color: const Color(0xff082D6D),
                    style: BorderStyle.solid,
                  )
                //color: const Color(0xff517fd2),
              ),
              child: Column(
                children: [
                  const Text('Mon suivi des CRA:'),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius:
                          BorderRadius.circular(10),
                          border: Border.all(
                            width: 0.75,
                            color: Colors.black,
                            style: BorderStyle.solid,
                          )
                        //color: const Color(0xff517fd2),
                      ),
                      child: InkWell(
                        onTap: () => showDialog(
                            context: Get.context!,
                            builder: (ctx) {
                              return Dialog(
                                child: Container(
                                  width: Get.width * 0.7,
                                  height: Get.height * 0.9,
                                  child: SfCalendar(
                                    //controller: _controller,
                                    backgroundColor: Colors.indigo.shade900,
                                    cellBorderColor: Colors.amber,
                                    headerStyle: const CalendarHeaderStyle(
                                      textStyle: TextStyle(color: Colors.white),
                                    ),
                                    viewHeaderStyle: const ViewHeaderStyle(
                                      dateTextStyle: TextStyle(color: Colors.white),
                                      dayTextStyle: TextStyle(color: Colors.white),
                                    ),
                                    view: CalendarView.workWeek,
                                    //onViewChanged: _viewChanged,
                                    timeSlotViewSettings: const TimeSlotViewSettings(
                                      startHour: 6,
                                      endHour: 20,
                                      timeTextStyle: TextStyle(color: Colors.white),
                                    ),
                                    //dataSource: UserCalendarDataSource(snapshot.data!),
                                    //onTap: onCalendarTapped,
                                    timeZone: 'Romance Standard Time',
                                    allowedViews: const [
                                      CalendarView.day,
                                      CalendarView.workWeek,
                                      CalendarView.month,
                                    ],
                                    showWeekNumber: true,
                                    weekNumberStyle: const WeekNumberStyle(
                                      backgroundColor: Colors.amber,
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    showNavigationArrow: true,
                                    selectionDecoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(color: Colors.white, width: 2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      shape: BoxShape.rectangle,
                                    ),
                                    todayHighlightColor: Colors.amber,
                                  ),
                                ),
                              );
                            },
                        ),
                        onHover: (value) {},
                        child: Column(
                          children: const [
                            Icon(
                              Icons.calendar_month_sharp,
                              color:
                              const Color(0xff082D6D),
                              size: 40,
                            ),
                            Text('Consulter')
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ],
  );
}