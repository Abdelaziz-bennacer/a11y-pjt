import 'dart:convert';

import 'package:a11y_pjt/app/global/ui/utils/dialog_util.dart';
import 'package:get/get.dart';
import '../../config/app_information.dart';
import '../errors/error_handler.dart';
import 'network_handler.dart';

class UploadAvatarProvider extends GetConnect with ErrorHandler{


  Future sendPic(List<int> avatar, String filename, int id) async{
    final String uploadPictureEndPoint = AppConstants.uploadPictureEndPoint;
    final String dbBaseUrl = AppConstants.dbBaseUrl;
    String url = '$dbBaseUrl$uploadPictureEndPoint';

    final form = FormData({

       "files": MultipartFile(avatar, filename: filename),
       "ref": "plugin::users-permissions.user",
      "refId": id,
      "field": "avatar",
       });
       
       try {
        var response = post(url, form);
        print(response);
        return response;
       }
       catch (e) {
        DialogUtil.showErrorDialog(e.toString());
       }
  }

  Future deletePicture(int id) async {
    final response = await NetworkHandler.put(
      {
          "avatar": null,
      },
      '/api/users/$id',
    );
    print('DELETE PIC1: $response');
  }
}