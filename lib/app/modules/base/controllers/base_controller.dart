import 'dart:html';
import 'dart:typed_data';
import 'package:a11y_pjt/app/data/providers/login_provider.dart';
import 'package:a11y_pjt/app/data/providers/upload_avatar_provider.dart';
import 'package:a11y_pjt/app/data/providers/user_provider.dart';
import 'package:a11y_pjt/app/modules/login/controllers/login_controller.dart';
import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../config/app_information.dart';


class BaseController extends GetxController {
  final userProvider = Get.put(UserProvider());
  final uploadAvatarProvider = Get.put(UploadAvatarProvider());
  final loginController = Get.find<LoginController>();
  final loginProvider = Get.find<LoginProvider>();

  final box = GetStorage();
  //var pathForView;// = box.read('imageAvatarLocalPath');

  //int? imageAvatarId;
  //String? imageAvatarLocalPath;
  //String? displayAvatarWithURL;

  XFile? file;
  File? file2;

  final XTypeGroup typeGroup =
  XTypeGroup(label: 'images', extensions: ['jpg', 'png']);


  var screenSize = Get.size;
  String? userAvatarURL;

void uploadPicture() async{
  file = (await openFile(acceptedTypeGroups: [typeGroup]));
  //imageAvatarLocalPath = file!.path;
  //box.write('imageAvatarLocalPath', imageAvatarLocalPath);

  Uint8List data = await file!.readAsBytes();
  List<int> list = data.cast();
  await uploadAvatarProvider.sendPic(list, '${loginController.username}_myfile', 2);
  
  var resp = await userProvider.getCurrentUser(loginController.currentUser.id);
  //print(resp['avatar']['formats']['small']['url']);
  String newUrl = '${AppConstants.dbBaseUrl}${resp['avatar']['formats']['small']['url']}';
  box.write('avatarServerURL', newUrl);
  update();
  //print (newUrl);
  
  loginController.currentUser = loginController.currentUser.copyWith(
      avatarURL: newUrl,
  );
    
  print(loginController.currentUser);
}

void deletePicture() {
  file = null;
  //loginProvider.updateUser({'avatarURL': null}, loginController.currentUser.id);
  loginController.currentUser = loginController.currentUser.copyWith(avatarURL: null);
  box.remove('avatarServerURL');
  print(loginController.currentUser);
  update();
}
}
