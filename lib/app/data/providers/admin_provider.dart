import 'dart:convert';

import 'package:a11y_pjt/app/data/errors/error_handler.dart';
import 'package:a11y_pjt/app/data/models/company_model/company_model.dart';
import 'package:a11y_pjt/app/data/models/folder_model/folder_model.dart';
import 'package:a11y_pjt/app/data/models/project_model/project_model.dart';
import 'package:a11y_pjt/app/data/models/service_model/service_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../global/ui/utils/dialog_util.dart';
import 'network_handler.dart';

class AdminProvider extends GetxService with ErrorHandler {

  Future<List<CompanyModel>> getCompanies() async {
    final response = await NetworkHandler.get('/api/companies?populate=deep').catchError(handleError);
    List<dynamic> dataX = response['data'];

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      throw Error();
    } else {
      //print('GET CURRENT USER: $response');
      final List<CompanyModel> companies = [];
      for (var data in dataX) {
        //var company = CompanyModel.fromJson(data);
        CompanyModel company = CompanyModel(
          uuid: data['attributes']['uuid'],
          name: data['attributes']['name'],
          //projects: <ProjectModel>[],
          //projects: data['attributes']['projects']['data'],        //projects: data["avatar"][0]["formats"]["small"]["url"]
          //firstName: data['firstName'],
          //email: data['email'],
          //fonction: data['fonction'],
        );
        companies.add(company);
      }
      return companies;
    }
  }

  Future<List<ProjectModel>> getProjects() async {
    final response = await NetworkHandler.get('/api/projects?populate=deep').catchError(handleError);
    //List<dynamic> dataX = response;

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      throw Error();
    } else {
      //print('GET CURRENT USER: $response');
      final List<ProjectModel> projects = [];
      for (var data in response) {
        //var company = CompanyModel.fromJson(data);
        ProjectModel project = ProjectModel(
          uuid: data['uuid'],
          name: data['name'],
          companyUUID: data['companyUUID'],
          //projects: <ProjectModel>[],
          //projects: data['attributes']['projects']['data'],        //projects: data["avatar"][0]["formats"]["small"]["url"]
          //firstName: data['firstName'],
          //email: data['email'],
          //fonction: data['fonction'],
        );
        projects.add(project);
      }
      return projects;
    }
  }

  Future<List<FolderModel>> getFolders() async {
    final response = await NetworkHandler.get('/api/folders?populate=deep').catchError(handleError);
    //final response = await http.get(Uri.parse('http://localhost:1337/api/folders?populate=deep'));
    List<dynamic> dataX = response['data'];
    //var dataX = response.body.toString();
    /*var dataXX = json.decode(dataX);
    print('RESPONSE FOLDERS2: $dataXX');
    //List<FolderModel> dataXXX = dataXX['data'];
    List<FolderModel> folders = [];
    for(var item in dataXX['data']) {
      print('ITEM: $item');
      var xXxX = item['attributes']['service_type']['data']['attributes']['name'];
      print('SERVICE AHAHAG: $xXxX');
      var y = item['attributes']['service_type'];
      print('SERVICE ITEM: $y');
      var x = y['data'];
      print('SERVICE ITEM PURE: $x');
      var z = x['attributes'];
      print('SERVICE ITEM PURE DE OUF: $z');
    }*/

    List<FolderModel> folders = [];
    for(var i=0;i<dataX.length;i++) {
      var deepObjectService = dataX[i]['attributes'];
      FolderModel folder = FolderModel(
          uuid: dataX[i]['attributes']['uuid'],
          name: dataX[i]['attributes']['name'],
          isActif: dataX[i]['attributes']['isActif'],
          projectUUID: dataX[i]['attributes']['projectUUID'],
          service: deepObjectService['service_type']['data']['attributes']['name'],
          /*uuid: dataX[i]['attributes']['uuid'],
          name: dataX[i]['attributes']['name'],
          isActif: dataX[i]['attributes']['isActif'],
          projectUUID: dataX[i]['attributes']['projectUUID'],*/
          //service:
      );
      folders.add(folder);
    }
    /*for(var item in dataX) {
      print('ITEM: $item');
      var x = dataX[0]['attributes'];
      print('FOLDER MAX: $x}');
      //var xXxX = item['attributes']['service_type']['data']['attributes']['name'];
      //print('SERVICE AHAHAG: $xXxX');
      //var y = item['attributes']['service_type'];
      //print('SERVICE ITEM: $y');
      //var x = y['data'];
      //print('SERVICE ITEM PURE: $x');
      //var z = x['attributes'];
      //print('SERVICE ITEM PURE DE OUF: $z');
      //}
    }*/
      /*FolderModel nieu = FolderModel(
            data: FolderData(attributes: PurpleAttributes(
            uuid: item['attributes']['uuid'],
            name: item['attributes']['name'],
            isActif: item['attributes']['isActif'],
            projectUuid: item['attributes']['projectUUID'],
            serviceType: ServiceType(data: ServiceTypeData(attributes: FluffyAttributes(name: item['attributes']['service_type']['data']['attributes']['name'])))
        ),
      ),
      );*/
      //folders.add(nieu);


    //print('RESPONSE FOLDERS3: $dataXXX');

    /*if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      throw Error();
    } else {
      //print('GET CURRENT USER: $response');
      final List<FolderModel> folders = [];
      for(var i=0;i<dataX.length;i++) {
        folders.add(folderFromJson(dataX[i]));
      }*/
      /*for (var data in dataX) {
        //var company = CompanyModel.fromJson(data);
        *//*FolderModel folder = FolderModel(
          uuid: data['attributes']['uuid'],
          name: data['attributes']['name'],
          isActif: data['attributes']['isActif'],
          projectUUID: data['attributes']['projectUUID'],
          service: data['attributes']['service_type']['data']['attributes']['name'],
          //projects: <ProjectModel>[],
          //projects: data['attributes']['projects']['data'],        //projects: data["avatar"][0]["formats"]["small"]["url"]
          //firstName: data['firstName'],
          //email: data['email'],
          //fonction: data['fonction'],
        );*//*
        FolderModel folder = folderFromJson(dataX);
        folders.add(folder);
      }*/
      return folders;
    }
  }

  /*Future<List<ServiceModel>> getServices() async {
    final response = await NetworkHandler.get('/api/folders?populate=deep').catchError(handleError);
    List<dynamic> dataX = response['data'];
    print('RESPONSE: $response');

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      throw Error();
    } else {
      //print('GET CURRENT USER: $response');
      final List<ServiceModel> services = [];
      for (var data in dataX) {
        //var company = CompanyModel.fromJson(data);
        ServiceModel service = ServiceModel(
          uuid: data['attributes']['uuid'],
          name: data['attributes']['name'],
        );
        services.add(service);
      }
      return services;
    }
  }*/


