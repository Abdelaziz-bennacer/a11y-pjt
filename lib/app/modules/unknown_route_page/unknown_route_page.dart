import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'unknown_route_controller.dart';

class UnknownRoutePage extends GetView<UnknownRouteController> {
  UnknownRoutePage() : super();

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('UnknownRoute'),
      );
  }
}
