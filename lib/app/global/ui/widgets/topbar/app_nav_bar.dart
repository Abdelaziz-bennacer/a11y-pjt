import 'package:a11y_pjt/app/global/ui/widgets/topbar/navigation_controller.dart';
import 'package:a11y_pjt/app/global/ui/widgets/topbar/topbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavBar extends GetView<NavigationController> {
  const AppNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
    preferredSize:
    Size(Get.width, Get.height),
    child: TopBarContents(),
    );
  }
}

PreferredSizeWidget appNavBar() {
  return PreferredSize(
    preferredSize:
    Size(Get.width, Get.height),
    child: TopBarContents(),
  );
}
