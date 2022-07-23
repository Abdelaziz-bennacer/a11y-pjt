import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/ui/main_layout.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginCTR = Get.find<LoginController>();
    return MainLayout(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
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
              children: [
                Column(
                  children: [
                    GetBuilder<BaseController>(builder: (ctr) {
                      return controller.box.read('avatarServerURL') != null
                          ? Image.network(
                        controller.box.read('avatarServerURL'),
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
                        return (controller.box.read('avatarServerURL') == null)
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
                //Text('Hello!')
                Column(
                  children: [
                    Text(loginCTR.userEmail!),
                    Text(loginCTR.userUUID!),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
