import 'package:a11y_pjt/app/data/models/critere_rgaa_model/critere_rgaa_model.dart';
import 'package:a11y_pjt/app/data/models/fiche_utile_model/fiche_utile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/thematique_rgaa_model/thematique_rgaa_model.dart';
import '../../../data/providers/utile_provider.dart';

class UtileRGAAController extends GetxController
    with StateMixin<List<ThematiqueRgaaModel>> {

  final utileProvider = Get.put(UtileProvider());
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();

  List<ThematiqueRgaaModel>? thematiquesRGAA;
  List<CritereRgaaModel>? criteresRGAA;
  List<FicheUtileModel>? fichesUtile;
  var isFicheUtileHovering = false.obs;


  var selelectedFiche = FicheUtileModel(
    id: 0,
    uuid: '',
    thematique: '',
    critere: '',
    critereNo: '',
    title: '',
    problem: '',
    solution: '',
    author: '',
    createdAt: DateTime.now(),
  ).obs;

  Future<List<ThematiqueRgaaModel>?> getThematiquesRGAA() async {
    var response = await utileProvider.getThematiquesRgaa();
    thematiquesRGAA = response;
    //print('THEMATIQUES CTR: $response');
    return thematiquesRGAA;
  }

  Future<List<CritereRgaaModel>?> getCriteresRGAA() async {
    var response = await utileProvider.getCriteresRgaa();
    //print('CRITERES CTR: $response');
    return response;
  }

  getCriteresParThematique(String name) {
    final list = criteresRGAA!.where((critere) =>
    critere.thematique.toLowerCase() == name.toLowerCase()).toList();
    //print('LISTE PAR CRITERE: $list');
    return list;
  }

  Future<List<FicheUtileModel>?> getFichesUtile() async {
    var response = await utileProvider.getFichesUtile();
    //print('FICHES CTR: $response');
    return response;
  }

  getFichesParCritere(String critere) {
    final list = fichesUtile!.where((fiche) =>
    fiche.critere.toLowerCase() == critere.toLowerCase()).toList();
    //print('LISTE PAR CRITERE: $list');
    return list;
  }

  Widget getFicheUtileItem(int index, List<FicheUtileModel> fiches) {
    return InkWell(
        onHover: (value) {
          value
              ? isFicheUtileHovering.value = true
              : isFicheUtileHovering.value = false;
        },
        onTap: () {
          selelectedFiche.value = fiches[index];
          print('SELECTED FICHE: ${selelectedFiche.value}');
          update();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: isFicheUtileHovering.value == false
                  ? Colors.white
                  : Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade500, width: 0.3),
            ),
            child: ListTile(
              title: Text(fiches[index].title),
            ),
          ),
        ),
      );
  }

  var panelSize = 0.0.obs;
  getPanelSize(List list) {
    print('LIST: $list');
    panelSize.value = list[0];
    print('PANEL: $panelSize');
  }


  @override
  void onInit() async {
    criteresRGAA = await getCriteresRGAA();
    fichesUtile = await getFichesUtile();
    getThematiquesRGAA().then((value) {
      change(value, status: RxStatus.success());
      getCriteresRGAA();
    }, onError: (error) {
      change(null, status: RxStatus.error(error));
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    scrollController2.dispose();
    super.onClose();
  }
}
