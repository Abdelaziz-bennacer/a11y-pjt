import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/team_board_controller.dart';

class TeamBoardView extends StatefulWidget {

  @override
  State<TeamBoardView> createState() => _TeamBoardViewState();
}

class InnerList {
  final String name;
  List<String> children;

  InnerList({required this.name, required this.children});
}

class _TeamBoardViewState extends State<TeamBoardView> {
  final teamBoardController = Get.find<TeamBoardController>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('TeamBoardView'),
        centerTitle: true,
      ),
      body: MediaQuery
          .of(context)
          .size
          .width > 900
          ? teamBoardController.buildScrollList(context, Axis.horizontal)
          : teamBoardController.buildScrollList(context, Axis.vertical),
    );
  }
}
