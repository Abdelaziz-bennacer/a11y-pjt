import 'package:a11y_pjt/app/modules/utile/controllers/utile_aria_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resizable_widget/resizable_widget.dart';

class UtileAriaView extends StatelessWidget {
  const UtileAriaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utileAriaController = Get.put(UtileAriaController());
    return Scaffold(
      body: Row(
        children: [
          MediaQuery.of(context).size.width > 700
          ? Container(
            width: 300,
            color: Colors.grey.shade100,
          ) : const SizedBox(),
          Expanded(
            child: ResizableWidget(
              isHorizontalSeparator: false,
              // optional
              isDisabledSmartHide: false,
              // optional
              separatorColor: Colors.grey.shade200,
              // optional
              separatorSize: 1,
              // optional
              percentages: const [0.5, 0.5],
              // optional
              onResized: (infoList) {
                utileAriaController.getPanelSize(infoList.map((x) => x.size).toList());
              },
              children: [
                Container(color: Colors.red,),
                Container(color: Colors.blue,),
                //Container(color: Colors.yellow,),
              ],
            ),
          )
        ],
      )
    );
  }
}
