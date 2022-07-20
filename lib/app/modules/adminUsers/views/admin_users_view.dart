import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../global/themes/themes.dart';
import '../../../global/ui/widgets/topbar/topbar_content.dart';
import '../controllers/admin_users_controller.dart';

class AdminUsersView extends GetView<AdminUsersController> {
  AdminUsersView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        Size(Get.size.width, Get.size.height),
        child: const TopBarContents(),
      ),
      body: Container(
        width: double.infinity,
        //padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
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
                      GridColumn(
                          columnName: 'id',
                          label: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ID',
                                style: Themes.headerAdminListTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ),
                      ),
                      GridColumn(
                          columnName: 'name',
                          label: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Name',
                                style: Themes.headerAdminListTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ),
                      ),
                      GridColumn(
                          columnName: 'designation',
                          label: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Designation',
                                style: Themes.headerAdminListTextStyle,
                                //overflow: TextOverflow.ellipsis,
                              ),
                          ),
                      ),
                      GridColumn(
                          columnName: 'salary',
                          label: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Salary',
                                style: Themes.headerAdminListTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ),
                      ),
                      ////////////****************////////////////:
                      GridColumn(
                        columnName: 'id2',
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ID2',
                            style: Themes.headerAdminListTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'name2',
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Name2',
                            style: Themes.headerAdminListTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'designation2',
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Designation2',
                            style: Themes.headerAdminListTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'salary2',
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Salary2',
                            style: Themes.headerAdminListTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      /////////////////***************//////////////
                    ],
                    source: controller.employeeDataSource,
                    selectionMode: SelectionMode.multiple,
                    allowSorting: true,
                    defaultColumnWidth: Get.width * 0.2,
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
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
    );
  }
}

class Employee {
  final int id;
  final String name;
  final String designation;
  final int salary;

  final int id2;
  final String name2;
  final String designation2;
  final int salary2;

  //Employee(this.id, this.name, this.designation, this.salary);
  Employee(this.id, this.name, this.designation, this.salary, this.id2, this.name2, this.designation2, this.salary2);
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) =>
        DataGridRow(cells: [
          DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
          DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
          DataGridCell<String>(
              columnName: 'designation', value: dataGridRow.designation),
          DataGridCell<int>(columnName: 'salary', value: dataGridRow.salary),
          ///////////////***************/////////////
          DataGridCell<int>(columnName: 'id2', value: dataGridRow.id),
          DataGridCell<String>(columnName: 'name2', value: dataGridRow.name),
          DataGridCell<String>(
              columnName: 'designation2', value: dataGridRow.designation),
          DataGridCell<int>(columnName: 'salary2', value: dataGridRow.salary),
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
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          /*alignment: (dataGridCell.columnName == 'id' ||
              dataGridCell.columnName == 'salary' || dataGridCell.columnName == 'id2' ||
              dataGridCell.columnName == 'salary2')
              ? Alignment.centerRight
              : Alignment.centerLeft,*/
          child: Text(
            dataGridCell.value.toString(), overflow: TextOverflow.ellipsis,),
        );
      }).toList(),
    );
  }


}
