import 'package:get/get.dart';

import '../controllers/team_board_controller.dart';

class TeamBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamBoardController>(
      () => TeamBoardController(),
    );
  }
}
