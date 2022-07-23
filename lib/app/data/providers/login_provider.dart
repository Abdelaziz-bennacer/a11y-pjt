import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../config/app_information.dart';
import '../../global/ui/utils/dialog_util.dart';
import '../errors/error_handler.dart';
import 'network_handler.dart';

class LoginProvider extends GetxService with ErrorHandler {
  final String registerEndPoint = AppConstants.loginEndPoint;
  final String userEndPoint = AppConstants.userEndPoint;

  Future login(Map<String, dynamic> body) async {
    var response = await NetworkHandler.post(
      body,
      registerEndPoint,
      //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTYsImlhdCI6MTY1NDQ2NTU1NSwiZXhwIjoxNjU3MDU3NTU1fQ.Sn0o-FqU_2KXB1KtL15lOdnqM8yzY7q3ZUFRsTE4Pug',
      //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjU0NjMwMDE3LCJleHAiOjE2NTcyMjIwMTd9.tepa8jatmTi9o51ZE0bidtDpj1wL2nmMJ0USDukFoqc',
    ).catchError(handleError);

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      return;
    } else {
      //print(response);
      return response;
    }
  }
   Future updateUser(Map<String, dynamic> body, int id) async {
    var response = await NetworkHandler.put(
        body,
      '/api/users/$id',
    ).catchError(handleError);

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      response.printError();
      return;
    } else {
      //print(response);
      return response;
    }
   }
}