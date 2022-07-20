
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/ui/widgets/topbar/topbar_content.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCTR = Get.find<HomeController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(controller.screenSize.width, controller.screenSize.height),
        child: const TopBarContents(),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffF2F6FE)),
            child: Row(
              children: [
                Column(
                  children: [
                    GetBuilder<HomeController>(builder: (ctr) {
                      return controller.file != null
                          ? Image.network(
                              controller.file!.relativePath!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 150,
                              width: 150,
                              child: Icon(
                                Icons.person,
                                size: MediaQuery.of(context).size.width * 0.1,
                                color: Colors.grey,
                              ),
                            );
                    }),
                    GetBuilder<HomeController>(
                  builder: (ctr) {
                    return (controller.file == null)
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              TextButton(
                                onPressed: () => controller.storeImage(), 
                                child: const Text(
                                      'Ajouter une photo',
                                    ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              TextButton(
                                onPressed: () => controller.deleteImage(), 
                                child: const Text(
                                      'Supprimer votre photo',
                                    ),
                              ),
                            ],
                          );
                  },
                ),
                  ],
                ),
                Text(homeCTR.user!.email!)
              ],
            ),
          )
        ],
      ),
      /* Center(
          child: Text(homeCTR.user!.email!),
        ), */
    );
  }
}

