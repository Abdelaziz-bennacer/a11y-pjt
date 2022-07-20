import 'package:get/get.dart';

import '../views/admin_users_view.dart';

class AdminUsersController extends GetxController {
  late List<Employee> employees;
  late EmployeeDataSource employeeDataSource;

  List<Employee> getEmployeeData() {
    return [
      /*Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Katryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 20000),
      Employee(10004, 'Michael', 'Designer', 20000),
      Employee(10005, 'Luis', 'Tech.Writer', 10000),
      Employee(10006, 'Allan', 'Developer', 22000),*/

      Employee(10001, 'James', 'Project Lead', 20000, 10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Katryn', 'Manager', 30000, 10002, 'Katryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 20000, 10003, 'Lara', 'Developer', 20000),
      Employee(10004, 'Michael', 'Designer', 20000, 10004, 'Michael', 'Designer', 20000),
      Employee(10005, 'Luis', 'Tech.Writer', 10000, 10005, 'Luis', 'Tech.Writer', 10000),
      Employee(10006, 'Allan', 'Developer', 22000, 10006, 'Allan', 'Developer', 22000),
    ];
  }

  final count = 0.obs;
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
    super.onClose();
  }

  late Map<String, double> columnWidths = {
    'id': double.nan,
    'name': double.nan,
    'designation': double.nan,
    'salary': double.nan
  };

  void increment() => count.value++;
}
