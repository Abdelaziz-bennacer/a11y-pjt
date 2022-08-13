import 'package:a11y_pjt/app/config/app_information.dart';
import 'package:a11y_pjt/app/data/models/fiche_utile_model/fiche_utile_model.dart';
import 'package:a11y_pjt/app/modules/utile/controllers/utile_rgaa_controller.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/idea.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../../../../data/models/critere_rgaa_model/critere_rgaa_model.dart';

class UtileRgaaView extends GetView<UtileRGAAController> {
  const UtileRgaaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utileRgaaController = Get.put(UtileRGAAController());
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ResizableWidget(
              isHorizontalSeparator: false,
              // optional
              isDisabledSmartHide: false,
              // optional
              separatorColor: Colors.grey.shade200,
              // optional
              separatorSize: 1,
              // optional
              percentages: const [0.4, 0.3, 0.3],
              // optional
              onResized: (infoList) {
                utileRgaaController.getPanelSize(infoList.map((x) => x.size).toList());
              },
              children: [ // required
                controller.obx((state) =>
                    Container(
                      color: Colors.grey.shade100,
                      height: MediaQuery.of(context).size.height - 100,
                      child: ListView.builder(
                        itemCount: utileRgaaController.thematiquesRGAA!.length,
                        itemBuilder: (context, index) {
                          List<CritereRgaaModel> criteres = utileRgaaController
                              .getCriteresParThematique(utileRgaaController
                              .thematiquesRGAA![index].name);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                //ElevatedButton(onPressed: () => utileController.updateFicheUuid(utileController.selelectedFiche.value.id), child: Text('PRESS')),
                                ListTile(
                                  leading: Text(
                                    utileRgaaController.thematiquesRGAA![index].number.toString(),
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  title: Text(
                                    utileRgaaController.thematiquesRGAA![index].name,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: criteres.length,
                                  itemBuilder: (context, index) {
                                    List<FicheUtileModel> fiches = utileRgaaController.getFichesParCritere(criteres[index].name);
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                                      child: Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.grey.shade500),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(9),
                                          child: Obx(() => utileRgaaController.panelSize > 230
                                              ? ExpansionTile(
                                                collapsedBackgroundColor: Colors.white,
                                                leading: Text(
                                                  criteres[index].number,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                //trailing: SizedBox(width: 1, height: 1, child: Icon(Icons.arrow_drop_down_circle_outlined),),
                                                title: RichText(
                                                  text: TextSpan(
                                                      text: criteres[index].name,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                            text: ' ',
                                                            children: [
                                                              TextSpan(
                                                                text: '${fiches.length} fiche(s)',
                                                                style: const TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.w700,
                                                                ),
                                                              )
                                                            ]
                                                        )
                                                      ]
                                                  ),
                                                ),
                                                children: [
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: fiches.length,
                                                    itemBuilder: (context, index) {
                                                      return Obx(() =>
                                                          utileRgaaController.getFicheUtileItem(index, fiches),
                                                      );
                                                    },
                                                  )
                                                ],
                                              ) : Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(color: Colors.grey.shade500),
                                                    ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(criteres[index].name,),
                                                  ),
                                          ),),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    controller: utileRgaaController.scrollController,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade500, width: 1,
                              )
                          ),
                          child: Text(
                            utileRgaaController.selelectedFiche.value.id == 0
                                ? 'Sélectionnez une fiche'
                                : utileRgaaController.selelectedFiche.value.title,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }),
                      const SizedBox(height: 25),
                      Obx(() {
                        return utileRgaaController.selelectedFiche.value.id == 0
                            ? const SizedBox()
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: RichText(
                                    text: TextSpan(
                                        text: 'Auteur: ',
                                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: utileRgaaController.selelectedFiche.value.author,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ]
                                    ),
                                )
                              ),
                              const Spacer(),
                              Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Publié le: ',
                                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: DateFormat('EEEE dd MMMM yyyy', 'fr').format(utileRgaaController.selelectedFiche.value.createdAt),
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ]
                                    ),
                                  )
                              ),
                            ],
                          ),
                        );
                      }),
                      Obx(() {
                        return utileRgaaController.selelectedFiche.value.id == 0
                            ? const SizedBox()
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Thématique: ',
                                      style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: utileRgaaController.selelectedFiche.value.thematique,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ]
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Critère: ',
                                      style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: utileRgaaController.selelectedFiche.value.critereNo,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ]
                                  ),
                                ),
                                //Text('Critère: ${utileController.selelectedFiche.value.critereNo}'),
                              ),
                              utileRgaaController.selelectedFiche.value.url == ''
                                  ? const SizedBox()
                                  : RichText(
                                text: TextSpan(
                                    text: "Url de l'exemple: ",
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                                    children: [
                                      TextSpan(
                                        text: '${utileRgaaController.selelectedFiche.value.url}',
                                        style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                                      )
                                    ]
                                ),
                              )
                              //Text("Url de l'exemple: ${utileController.selelectedFiche.value.url}"),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 15),
                      Obx(() =>
                      utileRgaaController.selelectedFiche.value.id == 0
                          ? const SizedBox()
                          : const Text(
                              'Problématique',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                              ),
                            ),),
                      Obx(() {
                        return utileRgaaController.selelectedFiche.value.id == 0
                          ? const SizedBox()
                          : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(utileRgaaController.selelectedFiche.value.problem, style: const TextStyle(color: Colors.black),),
                        );
                      }),
                      Row(
                        children: [
                          Obx(() {
                            return utileRgaaController.selelectedFiche.value.imageUrl1 == null
                                ? const SizedBox()
                                : Expanded(
                              child: Image.network(
                                '${AppConstants.dbBaseUrl}${utileRgaaController.selelectedFiche.value.imageUrl1!}',
                                width: 400,
                                height: 400,
                                fit: BoxFit.contain,
                              ),
                            );
                          }),
                          Obx(() {
                            return utileRgaaController.selelectedFiche.value.imageUrl2 == null
                                ? const SizedBox()
                                : Expanded(
                              child: Image.network(
                                '${AppConstants.dbBaseUrl}${utileRgaaController.selelectedFiche.value.imageUrl2!}',
                                width: 400,
                                height: 400,
                                fit: BoxFit.contain,
                              ),
                            );
                          }),
                        ],
                      ),
                      Obx(() =>
                      utileRgaaController.selelectedFiche.value.id == 0
                          ? const SizedBox()
                          : const Text(
                        'Solution',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),),
                      Obx(() {
                        return utileRgaaController.selelectedFiche.value.id == 0
                          ? const SizedBox()
                          : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(utileRgaaController.selelectedFiche.value.solution, style: const TextStyle(color: Colors.black),),
                        );
                      }),
                      const SizedBox(height: 30,)
                    ],
                  ),
                ),
                Container(
                    color: Colors.grey.shade100,
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      controller: utileRgaaController.scrollController2,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return utileRgaaController.selelectedFiche.value.id == 0
                            ? const SizedBox()
                            : Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade500, width: 1)
                            ),
                            child: const Text('Exemple', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                          );
                        }),
                        const SizedBox(height: 25),
                        Obx(() =>
                        utileRgaaController.selelectedFiche.value.id == 0
                            ? const SizedBox()
                            : const Text(
                          'Mauvaise pratique',
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),),
                        const SizedBox(height: 25),
                        Obx(() =>
                        utileRgaaController.selelectedFiche.value.code1 == null
                            ? const SizedBox()
                            : Column(
                              children: [
                                HighlightView(
                                    utileRgaaController.selelectedFiche.value.code1!,
                                    language: 'htmlBars',
                                    theme: ideaTheme,
                                ),
                              ],
                            )
                        ),
                        const SizedBox(height: 25),
                        Obx(() =>
                        utileRgaaController.selelectedFiche.value.id == 0
                            ? const SizedBox()
                            : const Text(
                          'Bonne pratique',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),),
                        const SizedBox(height: 25),
                        Obx(() =>
                        utileRgaaController.selelectedFiche.value.code2 == null
                            ? const SizedBox()
                            : Column(
                          children: [
                            HighlightView(
                              utileRgaaController.selelectedFiche.value.code2!,
                              language: 'htmlBars',
                              theme: ideaTheme,
                            ),
                          ],
                        ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
