import 'package:a11y_pjt/app/data/providers/user_provider.dart';
import 'package:a11y_pjt/app/global/ui/utils/dialog_util.dart';
import 'package:a11y_pjt/app/modules/login/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../data/models/user_model/user_model.dart';
import '../../../global/themes/themes.dart';
import '../views/admin_users_view.dart';

class AdminUsersController extends GetxController with StateMixin<List<UserModel>> {
  late List<UserModel> employees;
  late EmployeeDataSource employeeDataSource;
  //EmployeeDataSource employeeDataSource = EmployeeDataSource(employees)
  final formKey = GlobalKey<FormState>().obs;
  TextEditingController nameController = TextEditingController();
  final userProvider = Get.put(UserProvider());

  /*List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Doe', 'Project Lead', 'example@gmail.com', false),
      Employee(10002, 'Katryn', 'Lara', 'Manager', 'example@gmail.com', true),
      Employee(10003, 'Lara', 'Favbian', 'Developer', 'example@gmail.com', false),
      Employee(10004, 'Michael', 'Jackson', 'example@gmail.com', 'Designer', false),
      Employee(10005, 'Luis', 'Sanchez', 'example@gmail.com', 'Tech.Writer', true),
      Employee(10006, 'Allan', 'Theo', 'example@gmail.com', 'Developer', false),
    ];
  }*/

  @override
  void onInit() async{
    super.onInit();
    generateUsersList();
    //employees = await fetchUsers();
    //employeeDataSource = EmployeeDataSource(employees);
    //fetchUsers();
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

  /*fetchUsers() async{
    employees = await userProvider.getUsersList();
    employeeDataSource = EmployeeDataSource(employees);
  }*/

  Future<List<UserModel>> generateUsersList() {
    var response = userProvider.getUsersList();
    return response;
  }
  Future<UserDataGridSource> getUsersDataSource() async {
    var usersList = await generateUsersList();
    return UserDataGridSource(usersList);
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'ID',
          //width: Get.width / 8,
          label: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text(
              'ID',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          ),
      ),
      GridColumn(
        columnName: 'NOM',
        //width: Get.width / 8,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'NOM',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'PRENOM',
        //width: Get.width / 8,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'PRENOM',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'FONCTION',
        //width: Get.width / 8,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'FONCTION',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'EMAIL',
        //width: Get.width / 8,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'EMAIL',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'ADMIN',
        //width: Get.width / 8,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'ADMIN',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'PROFIL',
        //width: Get.width / 8,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'ADMIN',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'SUPPRIMER',
        //width: Get.width / 8,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ElevatedButton(
                onPressed: () {},
                child: Get.width > 1000 ? Text('Supprimer') : Icon(Icons.delete),
              );
            },
          ),
        ),
      ),
    ];
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
