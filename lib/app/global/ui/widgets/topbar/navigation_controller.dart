import 'package:get/get.dart';

import '../../../../modules/base/controllers/dashboard_calendar_component_controller.dart';
import '../../../../routes/app_pages.dart';
class NavigationController extends GetxController {
  final userCalendar = Get.find<DashBoardCalendarController>();

  var screenWidth = Get.width.obs;

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
      case 'Liste':
        Get.toNamed(AppPages.ADMIN_USERS);
        break;
      case 'Planification':
          Get.offAndToNamed(AppPages.ADMIN_CALENDAR);
          userCalendar.update();
        break;
      case 'Messages':
          Get.toNamed(AppPages.TEST);
          break;
      case 'DashBoard':
        Get.toNamed(AppPages.TEAM_BOARD);
        break;
      case 'Utile':
        Get.toNamed(AppPages.UTILE);
        break;
      default:
        () {};
      //default: Get.offAndToNamed(AppPages.BASE);
    }
  }

}