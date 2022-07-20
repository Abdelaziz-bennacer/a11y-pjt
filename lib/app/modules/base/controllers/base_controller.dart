//import 'dart:html';

import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  //var uuid = const Uuid();
  //User? user = FirebaseAuth.instance.currentUser!;
  //SharedPreferences? sharedPreferences;

  //ImageAvatar imageAvatar = ImageAvatar();

  int? imageAvatarId;
  String? imageAvatarLocalPath;
  String? displayAvatarWithURL;

  XFile? file;
  //File? file2;

  final XTypeGroup typeGroup =
  XTypeGroup(label: 'images', extensions: ['jpg', 'png']);


  var screenSize = Get.size;
  //File? file;

  //String? imageAvatarPath;
  String? userAvatarURL;

  //XFile? file;
  //File? file2;

  /* final XTypeGroup typeGroup =
      XTypeGroup(label: 'images', extensions: ['jpg', 'png']); */

  /*void uploaodImageWeb() {  //{required Function(File file) onSelected}
    InputElement uploadInput = FileUploadInputElement() as InputElement..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file!);
      reader.onLoadEnd.listen((event) {
        //onSelected(file!);
        imageAvatarURL = file!.relativePath;
        update();
      });
    });
  }*/
   */

void pic() async {
  file = (await openFile(acceptedTypeGroups: [typeGroup]));
  imageAvatarLocalPath = file!.path;
  update();
}

void deletePicture() {
  imageAvatarLocalPath = null;
  file = null;
  update();
}
}
