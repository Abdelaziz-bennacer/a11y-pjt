import 'package:a11y_pjt/app/modules/adminUsers/controllers/admin_view_tabs_controller.dart';
import 'package:a11y_pjt/app/modules/adminUsers/views/admin_users_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'admin_companies_view.dart';

class AdminGloBalView extends StatelessWidget {
  const AdminGloBalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminViewTabsController = Get.put(AdminViewTabsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Utilisateurs',
          style: GoogleFonts.acme(),
        ),
        centerTitle: true,
        //bottom:
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade100,
            child: TabBar(
              labelColor: Colors.redAccent,
              //labelStyle: GoogleFonts.roboto(color: Colors.red),
              unselectedLabelColor: Colors.blueAccent,
              controller: adminViewTabsController.tabController,
              tabs: adminViewTabsController.adminViewTabsList,
            ),
          ),
          Expanded(
            flex: 3,
            child: TabBarView(
              controller: adminViewTabsController.tabController,
              children: [
                AdminUsersView(),
                AdminCompaniesView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
