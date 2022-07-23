import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'navigation_controller.dart';

class TopBarContents extends GetView<NavigationController> {
  const TopBarContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(NavigationController());

    return Container(
      //color: const Color(0xffF2F6FE),
      height: Get.height * 0.13,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'A11Y.Manager',
              style: TextStyle(
                color: Color(0xfff44346),
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),

            Row(
              children: [
                Obx(() => getTopBarMenuItem(0, 'DashBoard'),),
            SizedBox(
              width: Get.width / 25,
            ),
            Obx(() => getTopBarMenuItem(1, 'Planification')),
            SizedBox(
              width: Get.width / 25,
            ),
            Obx(() => getTopBarMenuItem(2, 'Statistiques')),
            SizedBox(
              width: Get.width / 25,
            ),
            Obx(() => getTopBarMenuItem(3, 'Messages')),
            SizedBox(
              width: Get.width / 25,
            ),
            Obx(() => getTopBarMenuItem(4, 'Liste')),
            ],
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.logout_sharp),
                    Text('Logout')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell getTopBarMenuItem(int index, String title) {
    return InkWell(
                onHover: (value) {
                  value
                      ? controller.isHovering[index] = true
                      : controller.isHovering[index] = false;
                },
                onTap: () {
                  controller.navigate(title);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.isHovering[index] 
                    ? Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xff082D6D)
                      ),
                      child: Text(
                        title,
                        style: GoogleFonts.acme(
                          color: const Color(0xfff44346), 
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    : Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        //color: Color(0xfff44346)
                      ),
                      child: Text(
                        title,
                        style: GoogleFonts.acme(color: const Color(0xff082D6D), fontSize: 20),//const TextStyle(color: Color(0xff077bd7)),
                      ),
                    )
                  ],
                ),
              );
  }
}