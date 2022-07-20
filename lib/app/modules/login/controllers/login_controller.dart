import 'package:a11y_pjt/app/data/models/user_model.dart';
import 'package:a11y_pjt/app/data/providers/login_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/login_model/login_model.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final uuid = const Uuid();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final loginProvider = Get.put(LoginProvider());

  int? userId = 0;
  String? userEmail;
  UserModel? currentUser;

  final formKey = GlobalKey<FormState>().obs;

  var isLoading = false;

  void displayIndicatorOrNot(bool isLoading) {
    if(isLoading) {
      Get.dialog(
      const Center(child: CircularProgressIndicator(),),
      barrierDismissible: false,
    );
    } else if (isLoading == false) {
      Get.back();
    }
  }

  Future submit() async {
    final form = formKey.value.currentState;
    isLoading = true;
    //displayIndicatorOrNot(isLoading);

    if (form!.validate()) {
      LoginModel loginModel = LoginModel(
        identifier: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      var response = await loginProvider.login(loginModel.toJson());
      var res = response['user']['email'];

      print('ctr resp: $res');

      if (response != null) {
        isLoading = false;
        currentUser = UserModel(
          uuid: response['user']['uuid'] == null ? uuid.v4() : response['user']['uuid'],
          name: response['user']['username'], 
          email: response['user']['email'], 
          function: 'auditeur',
        );
        //print(response['user']['id']);
        if (response['user']['uuid'] == null) {
          var resp = await loginProvider.updateUser(
            {"uuid": currentUser!.uuid},
            //currentUser!.toJson(),
              response['user']['id'],
          );
          print('User to update: $resp');
          print('User uuid updated');
        }
        print('USER: $currentUser');
        Get.toNamed(AppPages.BASE);
        //Get.back();
      }
    }

    //Get.back();
      
  }

  /* Future submit() async {
    final form = formKey.value.currentState;
    isLoading = true;
    displayIndicatorOrNot(isLoading);

    if (form!.validate()) {
      form.save();

      final response = await loginProvider.login(
          emailTextFieldController.text, passwordTextFieldController.text);
      isLoading = true;
      //displayIndicatorOrNot(isLoading);
      userId = response['user']['id'];
      //sharedPreferences!.setInt("userId", userId!);
      update();

      userEmail = emailTextFieldController.text;
      //sharedPreferences!.setString("userEmail", userEmail!);
      update();

      /* Get.dialog(AlertDialog(
        contentPadding: EdgeInsets.zero,
        title: const Text(
          'BRAVO!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        content: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.check,
                color: Colors.green,
                size: 50,
              ),
            ],
          ),
        ),
      )); */

      /* Future.delayed(
          const Duration(seconds: 2), () => Get.toNamed(AppPages.INITIAL));
      update(); */
    }
    Get.back();
  } */

}