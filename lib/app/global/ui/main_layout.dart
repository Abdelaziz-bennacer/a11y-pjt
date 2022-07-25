import 'package:a11y_pjt/app/global/ui/widgets/topbar/app_nav_bar.dart';
import 'package:a11y_pjt/app/global/ui/widgets/topbar/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    //final navigationController = Get.put(NavigationController());
    return Scaffold(
          appBar: MediaQuery.of(context).size.width > 1080
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
      drawer: MediaQuery.of(context).size.width < 1080 ? const Drawer() : null,
      body: widget.child,
    );
  }
}
