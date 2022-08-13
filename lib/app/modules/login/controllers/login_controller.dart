
import 'package:a11y_pjt/app/config/app_information.dart';
import 'package:a11y_pjt/app/data/models/user_model/user_model.dart';
import 'package:a11y_pjt/app/data/providers/login_provider.dart';
import 'package:a11y_pjt/app/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/login_model/login_model.dart';
import '../../../data/providers/upload_avatar_provider.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final uuid = const Uuid();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final loginProvider = Get.put(LoginProvider());
  final userProvider = Get.put(UserProvider());
  final uploadAvatarProvider = Get.put(UploadAvatarProvider());

  int? userId;
  String? userUUID;
  String? userEmail;
  String? username;
  late UserModel currentUser;

  final formKey = GlobalKey<FormState>().obs;

  var isLoading = false;

  @override
  void onClose() {
    //emailController.dispose();
    //passwordController.dispose();
    super.onClose();
  }

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
      userId = response['user']['id'];
      username = response['user']['username'];
      userEmail = response['user']['email'];
      userUUID = response['user']['uuid'];

      if (response != null) {
        var resp = await userProvider.getCurrentUser(userId!);
        /* print('USER RESPONSE: ${resp['uuid']}');
        print('USER RESPONSE: ${resp['username']}');
        print('USER RESPONSE: ${resp['name']}');
        print('USER RESPONSE: ${resp['firstname']}');
        print('USER RESPONSE: ${resp['email']}');
        print('USER RESPONSE: ${resp['function']}');
        print('USER RESPONSE: ${resp['isAdmin']}');
        print('USER RESPONSE: ${resp['avatar']['formats']['small']['url']}'); */
        isLoading = false;
        currentUser = UserModel(
          id: resp['id'],
          uuid: resp['uuid'],
          username: resp['username'],
          name: resp['name'], 
          firstname: resp['firstname'],
          email: resp['email'], 
          function: resp['function'],
          isAdmin: resp['isAdmin'],
          avatarURL: resp['avatar'] != null 
            ? '${AppConstants.dbBaseUrl}${resp['avatar']['formats']['medium']['url']}'
            : null,
        );
        print('CURRENT USER: $currentUser');
        if (response['user']['uuid'] == null) {
          var resp2 = await loginProvider.updateUser(
            {"uuid": userUUID},
            //currentUser!.toJson(),
              response['user']['id'],
          );
          //print('$resp2');
          //print('User uuid updated');
        }
        //print('USER: $currentUser');
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