import 'package:flutter/material.dart';
import '../../../../../controllers/base_controller.dart';

Container buildInternCraComponent(BaseController controller) {
  return Container(
    child: Row(
      children: [
        Expanded(
          child: RadioListTile(
            title: const Text(
              'Réunion',
              overflow: TextOverflow.ellipsis,
            ),
            activeColor: Colors.blue,
            value: 'Réunion',
            groupValue: controller.selectedInterProject,
            onChanged: (String? value) =>
                controller.onClickInternProjectRadioButton(value!),
          ),
        ),
        //const SizedBox(width: 200),
        Expanded(
          child: RadioListTile(
            title: const Text(
              'Entretien individuel',
              overflow: TextOverflow.ellipsis,
            ),
            activeColor: Colors.blue,
            value: 'Entretien',
            groupValue: controller.selectedInterProject,
            onChanged: (String? value) =>
                controller.onClickInternProjectRadioButton(value!),
          ),
        ),
        Expanded(
          child: RadioListTile(
            title: const Text(
              'Projet a11y',
              overflow: TextOverflow.ellipsis,
            ),
            activeColor: Colors.blue,
            value: 'Projet',
            groupValue: controller.selectedInterProject,
            onChanged: (String? value) {
              controller.onClickInternProjectRadioButton(value!);
            },
          ),
        ),
      ],
    ),
  );
}