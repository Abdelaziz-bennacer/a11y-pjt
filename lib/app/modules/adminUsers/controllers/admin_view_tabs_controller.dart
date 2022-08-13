

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminViewTabsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> adminViewTabsList = <Tab>[
    const Tab(
      text: 'Utilisateurs',
    ),
    const Tab(
      text: 'Clients',
    ),
    /*const Tab(
      text: 'Projets',
    ),
    const Tab(
      text: 'Dossiers',
    ),
    const Tab(
      text: 'Prestations',
    ),*/
  ];

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}