import 'package:a11y_pjt/app/data/errors/error_handler.dart';
import 'package:a11y_pjt/app/data/models/critere_rgaa_model/critere_rgaa_model.dart';
import 'package:a11y_pjt/app/data/models/fiche_utile_model/fiche_utile_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../global/ui/utils/dialog_util.dart';
import '../models/thematique_rgaa_model/thematique_rgaa_model.dart';
import 'network_handler.dart';

class UtileProvider extends GetxService with ErrorHandler {
  final uuid = const Uuid();

  Future<List<ThematiqueRgaaModel>> getThematiquesRgaa() async {
    List<ThematiqueRgaaModel> list = [];
    final response = await NetworkHandler.get('/api/rgaa-thematiques?populate=deep').catchError(handleError);
    //print('RESPONSE: $response');
    List<dynamic> dataX = response['data'];

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      throw Error();
    } else {
      final List<ThematiqueRgaaModel> thematiques = [];
      for (var data in dataX) {
        ThematiqueRgaaModel thematique = ThematiqueRgaaModel(
          id: data['id'],
          uuid: data['attributes']['uuid'] ?? uuid.v4(),
          name: data['attributes']['thematique'],
          number: data['attributes']['number'],
          //criteres: data['attributes']['criteres']['data'],
        );
        thematiques.add(thematique);
      }
      //print('CRITERES: $thematiques');
      return thematiques;
      /*print('CRITERE FROM JSON: $list');
      return list;*/
    }
  }

  Future<List<CritereRgaaModel>> getCriteresRgaa() async {
    List<CritereRgaaModel> list = [];
    final response = await NetworkHandler.get('/api/rgaa-criteres?populate=deep&pagination[pageSize]=110').catchError(handleError);
    //print('RESPONSE: $response');
    List<dynamic> dataX = response['data'];

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      throw Error();
    } else {
      final List<CritereRgaaModel> criteres = [];

      for (var data in dataX) {
        CritereRgaaModel critere = CritereRgaaModel(
          id: data['id'],
          uuid: data['attributes']['uuid'] ?? uuid.v4(),
          name: data['attributes']['critere'],
          number: data['attributes']['number'],
          thematique: data['attributes']['rgaa_thematique']['data']['attributes']['thematique'],
        );
        criteres.add(critere);
      }
      //print('CRITERES: $criteres');
      return criteres;
    }
  }

  Future updateFicheUtileUuid(int id) async {
    var response = await NetworkHandler.put(
      {
        "data" : {
          "uuid": uuid.v4(),
        }
      },
      '/api/fiche-utiles/$id',
    );
    //print(response);
    return response['data']['attributes']['uuid'];
  }

  Future<List<FicheUtileModel>> getFichesUtile() async {
    List<FicheUtileModel> list = [];
    final response = await NetworkHandler.get('/api/fiche-utiles?populate=deep').catchError(handleError);
    //print('RESPONSE FICHES: $response');
    List<dynamic> dataX = response['data'];

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      throw Error();
    } else {
      final List<FicheUtileModel> fiches = [];

      for (var data in dataX) {
        FicheUtileModel fiche = FicheUtileModel(
          id: data['id'],
          uuid: data['attributes']['uuid'] != null ? data['attributes']['uuid'] : updateFicheUtileUuid(data['id']),
          thematique: data['attributes']["thematique"]['data']['attributes']['thematique'],
          title: data['attributes']['title'],
          solution: data['attributes']['solution'],
          author: data['attributes']['author'],
          critere: data['attributes']['critere']['data']['attributes']['critere'],
          critereNo: data['attributes']['critere']['data']['attributes']['number'],
          problem: data['attributes']['problematique'],
          imageUrl1: data['attributes']['image1']['data']['attributes']['formats']['small']['url'],
          imageUrl2: data['attributes']['image2']['data']['attributes']['formats']['small']['url'],
          createdAt: DateTime.parse(data['attributes']['createdAt']),
          url: data['attributes']['url'],
          code1: data['attributes']['code_problem'],
          code2: data['attributes']['code_recom'],
        );
        fiches.add(fiche);
      }
      print('FICHES: $fiches');
      return fiches;
    }
  }

  /*Future<List<ProjectModel>> getProjects() async {
    final response = await NetworkHandler.get('/api/projects?populate=deep').catchError(handleError);

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      throw Error();
    } else {

      final List<ProjectModel> projects = [];
      for (var data in response) {

        ProjectModel project = ProjectModel(
          uuid: data['uuid'],
          name: data['name'],
          companyUUID: data['companyUUID'],

        );
        projects.add(project);
      }
      return projects;
    }
  }*/

  /*Future<List<FolderModel>> getFolders() async {
    final response = await NetworkHandler.get('/api/folders?populate=deep').catchError(handleError);
    List<dynamic> dataX = response['data'];


    List<FolderModel> folders = [];
    for(var i=0;i<dataX.length;i++) {
      var deepObjectService = dataX[i]['attributes'];
      FolderModel folder = FolderModel(
        uuid: dataX[i]['attributes']['uuid'],
        name: dataX[i]['attributes']['name'],
        isActif: dataX[i]['attributes']['isActif'],
        projectUUID: dataX[i]['attributes']['projectUUID'],
        service: deepObjectService['service_type']['data']['attributes']['name'],

      );
      folders.add(folder);
    }
    return folders;
  }*/
}