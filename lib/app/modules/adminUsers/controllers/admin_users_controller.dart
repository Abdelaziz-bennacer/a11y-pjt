import 'package:a11y_pjt/app/global/ui/utils/dialog_util.dart';
import 'package:a11y_pjt/app/modules/login/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../global/themes/themes.dart';
import '../views/admin_users_view.dart';

class AdminUsersController extends GetxController {
  late List<Employee> employees;
  late EmployeeDataSource employeeDataSource;
  final formKey = GlobalKey<FormState>().obs;
  TextEditingController nameController = TextEditingController();

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Doe', 'Project Lead', 'example@gmail.com', false),
      Employee(10002, 'Katryn', 'Lara', 'Manager', 'example@gmail.com', true),
      Employee(10003, 'Lara', 'Favbian', 'Developer', 'example@gmail.com', false),
      Employee(10004, 'Michael', 'Jackson', 'example@gmail.com', 'Designer', false),
      Employee(10005, 'Luis', 'Sanchez', 'example@gmail.com', 'Tech.Writer', true),
      Employee(10006, 'Allan', 'Theo', 'example@gmail.com', 'Developer', false),
    ];
  }

  @override
  void onInit() {
    super.onInit();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employees);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  columnTableWidget(String columnName, String title) {
    return GridColumn(
      columnName: columnName,
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        alignment: columnName == 'id' ? Alignment.centerLeft : Alignment.center,

        child: Text(
          title,
          style: Themes.headerAdminListTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
  addNewUser() {
    //DialogUtil.showRegisterDialog(nameController, formKey.value, 'description');
      Get.dialog(Dialog(
        child: Scaffold(
          appBar: AppBar(title: Text('Nouvel utilisateur'),),
          body: Container(
            width: double.infinity,
            height: Get.height * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey.value,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffF2F6FE),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: TextFormField(
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
                              ),
                            ),
                            SizedBox(width: 25),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffF2F6FE),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: TextFormField(
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
                              ),
                            ),
                          ],
                        ),
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
          ),
        ),
      ));

    /*Get.defaultDialog(
      content: Material(
        child: Container(
          width: Get.width * 0.4,
          height: Get.height * 0.4,
          child:
        ),
      )
    );*/
  }
}
