

import 'package:get/get.dart';

class UtileAriaController extends GetxController {

  var panelSize = 0.0.obs;
  getPanelSize(List list) {
    print('LIST: $list');
    panelSize.value = list[0];
    print('PANEL: $panelSize');
  }
}