import 'package:a11y_pjt/app/modules/adminUsers/controllers/admin_view_tabs_controller.dart';
import 'package:a11y_pjt/app/modules/adminUsers/views/admin_users_view.dart';
import 'package:a11y_pjt/app/modules/utile/views/tabs/utile_aria_view.dart';
import 'package:a11y_pjt/app/modules/utile/views/tabs/utile_rgaa_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/utile_view_tabs_controller.dart';

class UtileView extends StatelessWidget {
  const UtileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utileViewTabsController = Get.put(UtileViewTabsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Utile',
          style: GoogleFonts.acme(),
        ),
        centerTitle: true,
        //bottom:
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              labelColor: Colors.redAccent,
              //labelStyle: GoogleFonts.roboto(color: Colors.red),
              unselectedLabelColor: Colors.blueAccent,
              controller: utileViewTabsController.tabController,
              tabs: utileViewTabsController.adminViewTabsList,
              isScrollable: false,
            ),
          ),
          Expanded(
            flex: 3,
            child: TabBarView(
              controller: utileViewTabsController.tabController,
              children: const [
                UtileRgaaView(),
                UtileAriaView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
