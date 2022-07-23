import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import 'widgets/custom_textfield.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: Get.size.height * 0.1),
                    //height: MediaQuery.of(context).size.height / 1.5,
                    //width: MediaQuery.of(context).size.width / 3.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                            'assets/logo.png',
                            height: MediaQuery.of(context).size.width / 8,
                            filterQuality: FilterQuality.high,
                          ),
                        const SizedBox(height: 30),
                        Material(
                          color: Colors.transparent,
                          child: Container(
                            //height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: Form(
                              key: controller.formKey.value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomTextField(
                                    data: Icons.email,
                                    controller: controller.emailController,
                                    hintText: "Email",
                                    isObscure: false,
                                    /*validator: (val) {
                                        if (!val!.isValidName) {
                                          return 'Entrez une adresse email valide';
                                        }
                                      },*/
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    data: Icons.lock,
                                    controller: controller.passwordController,
                                    hintText: "Mot de passe",
                                    isObscure: true,
                                    /*validator: (val) {
                                        if (!val!.isValidPassword || val.length < 6) {
                                          return 'Entrez un mot de passe valide';
                                        }
                                      },*/
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.submit();
                                    },
                                    child: const Text(
                                      'CONNEXION',
                                      //style: TextStyle(color: Colors.amber),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Mot de passe oublié',
                                      //style: TextStyle(color: Colors.amber),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}

