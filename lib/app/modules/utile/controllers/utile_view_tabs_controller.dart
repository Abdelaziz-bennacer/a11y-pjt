import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtileViewTabsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> adminViewTabsList = <Tab>[
    Tab(
      child: Container(
        color: Colors.white,
        child: Text('RGAA'),
      ),
      //text: 'RGAA',
    ),
    Tab(
      child: Container(
        color: Colors.white,
        child: Text('WAI-ARIA'),
      )
      //text: 'WAI-ARIA',
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