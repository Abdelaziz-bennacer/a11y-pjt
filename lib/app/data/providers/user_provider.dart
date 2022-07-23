import 'package:a11y_pjt/app/data/errors/error_handler.dart';
import 'package:get/get.dart';
import '../../config/app_information.dart';
import '../../global/ui/utils/dialog_util.dart';
import 'network_handler.dart';


class UserProvider extends GetxService with ErrorHandler{
  final String uploadPictureEndPoint = AppConstants.uploadPictureEndPoint;
  final String dbBaseUrl = AppConstants.dbBaseUrl;


  Future getCurrentUser(int id) async {
    var response = await NetworkHandler.get(
      '/api/users/$id?populate=*',
      //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTYsImlhdCI6MTY1NDQ2NTU1NSwiZXhwIjoxNjU3MDU3NTU1fQ.Sn0o-FqU_2KXB1KtL15lOdnqM8yzY7q3ZUFRsTE4Pug',
      //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjU0NjMwMDE3LCJleHAiOjE2NTcyMjIwMTd9.tepa8jatmTi9o51ZE0bidtDpj1wL2nmMJ0USDukFoqc',
    ).catchError(handleError);

    if (response == null) {
      DialogUtil.showErrorDialog('Data null');
      return;
    } else {
      //print('GET CURRENT USER: $response');
      return response;
    }
  }

}