import 'package:a11y_pjt/app/modules/base/views/components/main/edit_cra_banner/widgets/cra_editor.dart';
import 'package:a11y_pjt/app/modules/base/views/components/main/edit_cra_banner/widgets/intern_cra_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/base_controller.dart';

Widget buildEditCRABannerContainer(BaseController controller) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      height: Get.height / 2.8,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 3,
            color: const Color(0xfff44346),
            style: BorderStyle.solid,
          )
          //color: const Color(0xff517fd2),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Saisir un Compte Rendu d'Activité",
                    style: GoogleFonts.acme(fontSize: 20),
                  ),
                ),
                Get.width > 1300
                    ? buildCRAEditor(controller)
                    : ElevatedButton(
                        onPressed: () => showDialog(
                            context: Get.context!,
                            builder: (ctx) {
                              return AlertDialog(
                                content: Container(
                                  width: Get.width * 0.8,
                                  height: Get.height * 0.4,
                                  child: Column(
                                    children: [
                                      buildCRAEditor(controller),
                                      const SizedBox(height: 40),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text('Valider'),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                        ),
                        child: const Text('Editer'),
                      ),
              ],
            ),
          ),
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1.5,
                color: const Color(0xfff44346),
                style: BorderStyle.solid,
              ),
              //color: const Color(0xff517fd2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<BaseController>(builder: (logic) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      DateFormat('EEEE dd MMMM yyyy', 'fr')
                          .format(logic.selectedDate)
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.acme(fontSize: 20),
                    ),
                    Text(controller.selectedUsage),
                    //controller.selectedUsage == "Interne" ?
                    //Text(controller.selectedInterProject) : Text(controller.selectedProjectName!),
                    controller.selectedUsage == "Interne" ? Column(
                      children: [
                        Text(controller.selectedInterProject),
                      ]
                    ) : Column(
                      children: [
                        controller.selectedCompanyName == null ? Text('Compagnie') : Text(controller.selectedCompanyName!),
                        controller.selectedProjectName == null ? Text('Project') : Text(controller.selectedProjectName!),
                        controller.selectedFolderName == null ? Text('Dossier') : Text(controller.selectedFolderName!),
                        //controller.selectedFolder!.service! == 'Audit RGAA' ? Text(controller.selectedFolder!.service!): SizedBox(),
                        controller.selectedFolder!.service! == 'Audit RGAA' && controller.selectedTheme != null ? Text(controller.selectedTheme!): SizedBox(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'De: ${logic.selectedStartDuration!.hour}:${controller.selectedStartDuration!.minute.toString().padLeft(2, "0")}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.acme(textBaseline: TextBaseline.alphabetic,),
                        ),
                        Text(
                          'à: ${logic.selectedEndDuration!.hour}:${controller.selectedEndDuration!.minute.toString().padLeft(2, "0")}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.acme(textBaseline: TextBaseline.alphabetic,),
                        ),
                        Text('total: ',style: GoogleFonts.acme(textBaseline: TextBaseline.alphabetic,),),
                        Text('${controller.craDuration.toString()} heure(s)',style: GoogleFonts.acme(textBaseline: TextBaseline.alphabetic,)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Valider'),
                    )
                  ],
                );
              }),
            ),
          )
        ],
      ),
    ),
  );
}


