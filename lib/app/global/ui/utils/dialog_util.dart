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

  //show register dialog
  static void showRegisterDialog(
      TextEditingController nameController,
      Key key,
      String description// = 'Something went wrong',
      ) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nouvel utilisateur',
              style: Get.textTheme.headline4,
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nouvel utilisateur',
                style: Get.textTheme.headline4,
              ),
              Column(
                children: [
                  Form(
                    key: key,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, overflow: TextOverflow.ellipsis),
                              //enabled: enabled,
                              controller: nameController,
                              //obscureText: isObscure!,
                              //cursorColor: Theme.of(context).primaryColor,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.cyan,
                                ),
                                //focusColor: Theme.of(context).primaryColor,
                                hintText: 'Nom',
                                //label: Text(label!),
                              ),
                              //inputFormatters: inputFormatters,
                              //validator: validator,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, overflow: TextOverflow.ellipsis),
                              //enabled: enabled,
                              controller: nameController,
                              //obscureText: isObscure!,
                              //cursorColor: Theme.of(context).primaryColor,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.cyan,
                                ),
                                //focusColor: Theme.of(context).primaryColor,
                                hintText: 'Prénom',
                                //label: Text(label!),
                              ),
                              //inputFormatters: inputFormatters,
                              //validator: validator,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text('Okay'),
                  )
                ],
              ),

            ],
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