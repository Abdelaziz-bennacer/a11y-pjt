import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class DialogUtil {
  //show error dialog
  static void showErrorDialog(
    String description// = 'Something went wrong',
  ) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Error',
              style: Get.textTheme.headline4,
            ),
            Text(
              description,
              style: Get.textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Text('Okay'),
            )
          ],
        ),
      ),
    ));
  }
  //show snackBar

  //show toast

  //show loading

  //hide loading
}