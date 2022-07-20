import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
class NavigationController extends GetxController {

  final isHovering = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
  ].obs;

  void navigate(String title) {
    switch (title) {
      case 'DashBoard':
        Get.offAndToNamed(AppPages.BASE);
        break;
      case 'Liste':
        Get.toNamed(AppPages.ADMIN_USERS);
        break;
      default: Get.offAndToNamed(AppPages.BASE);
    }
  }

}