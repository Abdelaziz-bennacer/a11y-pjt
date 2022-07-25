import 'package:a11y_pjt/app/modules/base/views/components/dash_board_calendar/dashboard_calendar_component_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../global/ui/main_layout.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return MainLayout(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  width: Get.width / 3,
                  height: Get.height / 3.3,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 3,
                        color: const Color(0xff082D6D),
                        style: BorderStyle.solid,
                      )
                    //color: const Color(0xff517fd2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(                       
                        children: [
                          GetBuilder<BaseController>(builder: (ctr) {
                            return loginController.currentUser.avatarURL != null
                                ? Image.network(
                              loginController.currentUser.avatarURL!,
                              //controller.box.read('avatarServerURL'),
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              height: MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Icon(
                                Icons.person,
                                size: MediaQuery.of(context).size.width * 0.1,
                                color: Colors.grey,
                              ),
                            );
                          }),
                          GetBuilder<BaseController>(
                            builder: (ctr) {
                              return (loginController.currentUser.avatarURL == null)
                                  ? Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextButton(
                                    onPressed: () => controller.uploadPicture(),
                                    child: const Text(
                                      'Ajouter une photo',
                                    ),
                                  ),
                                ],
                              )
                                  : Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextButton(
                                    onPressed: () => controller.deletePicture(),
                                    child: const Text(
                                      'Supprimer votre photo',
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                loginController.currentUser.firstname,
                                style: GoogleFonts.acme(
                                  color: const Color(0xff082D6D),
                                  fontSize: 40
                                  ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                loginController.currentUser.name,
                                style: GoogleFonts.acme(
                                  color: const Color(0xff082D6D),
                                  fontSize: 35
                                  ),
                              ),
                            ],
                            ),
                            const SizedBox(height: 30),
                            Text(
                              loginController.currentUser.function,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 25
                                  ),
                              ),
                            const SizedBox(height: 30),  
                            Text(
                              loginController.currentUser.email,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 25
                                  ),
                              ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.all(10),
                    height: Get.height / 3.3,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 3,
                          color: const Color(0xfff44346),
                          style: BorderStyle.solid,
                        )
                      //color: const Color(0xff517fd2),
                    ),
                    child: Container(),
                          ),
                ),
              ],
            ),
            DashBoardCalendarComponent(),
          ],
        ),
      ),
    );
  }
}
