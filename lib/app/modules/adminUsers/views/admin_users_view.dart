import 'package:a11y_pjt/app/global/ui/widgets/topbar/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../global/ui/widgets/topbar/topbar_content.dart';
import '../controllers/admin_users_controller.dart';

class AdminUsersView extends GetView<AdminUsersController> {
  AdminUsersView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utilisateurs', style: GoogleFonts.acme(),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () {
                      controller.addNewUser();
                    },
                    child: Text('Ajouter un utilisateur'),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            //padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 3,
                  color: const Color(0xff082D6D),
                  style: BorderStyle.solid,
                )
              //color: const Color(0xff517fd2),
            ),
            child: Center(
              child: GetBuilder<AdminUsersController>(builder: (logic) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: SfTheme(
                    data: SfThemeData(
                      dataGridThemeData: SfDataGridThemeData(
                        headerColor: const Color(0xff082D6D),
                      )
                    ),
                    child: SfDataGrid(
                        columns: [
                          controller.columnTableWidget('id', 'ID'),
                          controller.columnTableWidget('name', 'NAME'),
                          controller.columnTableWidget('firstname', 'Prénom'),
                          controller.columnTableWidget('email', 'Email'),
                          controller.columnTableWidget('function', 'Fonction'),
                          controller.columnTableWidget('isAdmin', 'Admin'),
                          controller.columnTableWidget('goToProfileBTN', 'Profil'),
                          controller.columnTableWidget('delete', 'Supprimer'),
                        ],
                        source: controller.employeeDataSource,
                        //selectionMode: SelectionMode.multiple,
                        allowSorting: true,
                        //defaultColumnWidth: Get.width * 0.12,
                        columnWidthMode: ColumnWidthMode.fill,
                       /* allowColumnsResizing: true,
                        onColumnResizeStart: (ColumnResizeStartDetails details) {
                          // disable resizing for the `salary` column.
                          if (details.column.columnName == 'salary') {
                            return false;
                          }
                          return true;
                        },
                        columnWidthMode: ColumnWidthMode.fitByCellValue,
                        onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                          controller.columnWidths[details.column.columnName] =
                              details.width;

                          return true;
                        },*/
                      ),
                  ),

                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class Employee {
  final int? id;
  final String? name;
  final String? firstname;
  final String? email;
  final String? function;
  bool? isAdmin;

  Employee(this.id, this.name, this.firstname, this.email, this.function, this.isAdmin,);
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) =>
        DataGridRow(cells: [
          DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
          DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
          DataGridCell<String>(
              columnName: 'firstname', value: dataGridRow.firstname),
          DataGridCell<String>(columnName: 'function', value: dataGridRow.function),
          DataGridCell<String>(columnName: 'email', value: dataGridRow.email),
          DataGridCell<bool>(columnName: 'isAdmin', value: dataGridRow.isAdmin),
          const DataGridCell<Widget>(columnName: 'goToProfileBTN', value: null),
          const DataGridCell<Widget>(columnName: 'delete', value: null),
        ]))
        .toList();
  }

  late List<DataGridRow> dataGridRows;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getBackgroundColor() {
      int index = effectiveRows.indexOf(row);
      if (index % 2 == 0) {
        return Colors.white;
      } else {
        return Colors.amber[50]!;
      }
    }
    return DataGridRowAdapter(
      color: getBackgroundColor(),
      cells: row.getCells().map<Widget>((dataGridCell) {
        Widget rowAdapter(String title, dynamic isAdminValue) {
          switch(title) {
            case 'goToProfileBTN':
              return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //primary: Get.width > 900 ? Colors.red : Colors.transparent,
                        textStyle: TextStyle(color: Colors.white)
                      ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  content: SizedBox(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Employee ID: ${row.getCells()[0].value.toString()}'),
                                          Text(
                                              'Employee Name: ${row.getCells()[1].value.toString()}'),
                                          Text(
                                              'Employee Designation: ${row.getCells()[2].value.toString()}'),
                                        ],
                                      ))));
                        },
                        child: Get.width > 1000 ? const Text('Details', overflow: TextOverflow.ellipsis,): Icon(Icons.remove_red_eye),
                    );
                  });
            case 'isAdmin':
              return isAdminValue == true ? Icon(Icons.check) : Icon(Icons.cancel_presentation);
            case 'delete':
              return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return ElevatedButton(
                        onPressed: () {},
                        child: Get.width > 1000 ? Text('Supprimer') : Icon(Icons.delete),
                    );
                  },
              );
            default:
              return Text(dataGridCell.value.toString(), overflow: TextOverflow.ellipsis,);
          }
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //alignment: Alignment.center,
          alignment: (dataGridCell.columnName == 'id')
              ? Alignment.centerLeft
              : Alignment.center,
          child: rowAdapter(dataGridCell.columnName, dataGridCell.value)
        );
      }).toList(),
    );
  }


}
