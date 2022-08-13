import 'package:a11y_pjt/app/modules/base/views/components/dash_board_calendar/dashboard_calendar_component_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/ui/main_layout.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/base_controller.dart';
import 'components/main/edit_cra_banner/edit_cra_banner.dart';
import 'components/main/profile_banner.dart';

class BaseView extends StatelessWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BaseController());
    final loginController = Get.find<LoginController>();
    return MainLayout(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                child: MediaQuery.of(context).size.width > 1080
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildProfileBannerContainer(
                              controller, loginController, context),
                          buildEditCRABannerContainer(controller),
                        ],
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Column(
                          children: [
                            buildProfileBannerContainer(
                                controller, loginController, context),
                            buildEditCRABannerContainer(controller),
                          ],
                        ),
                      ),
              ),
            ),
            DashBoardCalendarComponent(),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: Get.height / 10,
              color: Colors.black87,
              child: const Center(child: Text('FOOTER', style: TextStyle(color: Colors.white),),),
            )
          ],
        ),
      ),
    );
  }
}
