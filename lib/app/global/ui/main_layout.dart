import 'package:a11y_pjt/app/global/ui/widgets/topbar/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Get.width > 1080
          ? appNavBar()
          : AppBar(
        title: const Text('A11Y.Manager'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout_sharp),
                  Text('Logout')
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Get.width > 1080 ? null : Drawer(),
      body: child,
    );
  }
}
