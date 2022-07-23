/* import 'dart:html';

import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';


class HomeController extends GetxController {
  var uuid = const Uuid();
  User? user = FirebaseAuth.instance.currentUser!;
  var user;

  var screenSize = Get.size;
  File? file;

  String? imageAvatarPath;
  String? userAvatarURL;

  XFile? file;
  File? file2;

  final XTypeGroup typeGroup =
      XTypeGroup(label: 'images', extensions: ['jpg', 'png']);

  void uploaodImageWeb({required Function(File file) onSelected}) {
    InputElement uploadInput = FileUploadInputElement() as InputElement..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file!);
      reader.onLoadEnd.listen((event) {
        onSelected(file!);
      });
    });
  }

  Future<void> storeImage() async {
    
    
  }

  Future<void> getImage() async {
    file = (await openFile(acceptedTypeGroups: [typeGroup]));
    update();
    file2 = File(file!.path);
    imageAvatarPath = file2!.path;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    fstorage.Reference reference = fstorage.FirebaseStorage.instance.ref().child("users").child(fileName);
    fstorage.UploadTask uploadTask = reference.putFile(File(file!.path));
    fstorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) {userAvatarURL = url;});    
  }

  void deleteImage() {}
}
 */*/