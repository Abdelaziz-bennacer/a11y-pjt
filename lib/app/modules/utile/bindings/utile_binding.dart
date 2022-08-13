import 'package:get/get.dart';

import '../controllers/utile_rgaa_controller.dart';

class UtileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UtileRGAAController>(
      () => UtileRGAAController(),
    );
  }
}
