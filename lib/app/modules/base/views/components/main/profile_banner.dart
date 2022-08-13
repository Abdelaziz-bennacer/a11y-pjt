import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../login/controllers/login_controller.dart';
import '../../../controllers/base_controller.dart';

Container buildProfileBannerContainer(BaseController controller, LoginController loginController, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(10),
    //width: Get.width / 3,
    height: Get.height / 2.8,
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
    child: Column(
      children: [
        Row(
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
                          color: const Color(0xff082D6D), fontSize: 40),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      loginController.currentUser.name,
                      style: GoogleFonts.acme(
                          color: const Color(0xff082D6D), fontSize: 35),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  loginController.currentUser.email,
                  style: GoogleFonts.roboto(color: Colors.black, fontSize: 25),
                ),
                const SizedBox(height: 30),

              ],
            )
          ],
        ),
        Text(
          loginController.currentUser.function,
          style: GoogleFonts.roboto(color: Colors.black, fontSize: 25),
        ),
      ],
    ),
  );
}