import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:teaching_evaluation_app/components/table_header_cell.dart';
import 'package:teaching_evaluation_app/consts/page_const.dart';
import 'package:teaching_evaluation_app/model/student_class/class_info.dart';
import 'package:teaching_evaluation_app/model/student_class/query/query_student_class_request.dart';
import 'package:teaching_evaluation_app/model/student_class/query/query_student_class_response.dart';
import 'package:teaching_evaluation_app/pages/class/class_data_vm.dart';
import 'package:teaching_evaluation_app/pages/class/components/class_edit_btn.dart';
import 'package:teaching_evaluation_app/pages/class/components/class_delete_btn.dart';
import 'package:teaching_evaluation_app/service/class_service.dart';
import 'package:teaching_evaluation_app/utils/time_util.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

class ClassTable extends StatefulWidget {
  const ClassTable({super.key});

  @override
  State<ClassTable> createState() => _ClassTableState();
}

class _ClassTableState extends State<ClassTable> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ClassDataViewModel>();
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.classInfoList.isEmpty) {
      return const Center(child: Text('暂无数据'));
    }

    final dataSource = ClassInfoDataSource(
      classInfoData: vm.classInfoList,
      onUpdated: vm.refresh,
    );

    return Expanded(
      child: SfDataGrid(
        source: dataSource!,
        columnWidthMode: ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.none,
        headerGridLinesVisibility: GridLinesVisibility.none,
    
        onCellTap: (details) {},
        columns: [
          GridColumn(columnName: 'id', label: TableHeaderCell(title: 'ID')),
          GridColumn(
            columnName: 'classNumber',
            label: TableHeaderCell(title: '班级编号'),
          ),
          GridColumn(
            columnName: 'createAt',
            label: TableHeaderCell(title: '创建时间'),
          ),
          GridColumn(
            columnName: 'operations',
            label: TableHeaderCell(title: '操作'),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(BuildContext context, ClassDataViewModel vm) {
    int totalPages =
        (vm.total / vm.currentPageSize).ceil() == 0
            ? 1
            : (vm.total / vm.currentPageSize).ceil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('共 ${vm.total} 条'),
        const SizedBox(width: 16),
        DropdownButton<int>(
          value: vm.currentPageSize,
          items: const [
            DropdownMenuItem(value: 10, child: Text('10条/页')),
            DropdownMenuItem(value: 20, child: Text('20条/页')),
            DropdownMenuItem(value: 50, child: Text('50条/页')),
          ],
          onChanged: (size) => vm.changePageSize(size!),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed:
              vm.currentPageNum > 1
                  ? () => vm.goToPage(vm.currentPageNum - 1)
                  : null,
        ),
        Text('${vm.currentPageNum} / $totalPages'),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed:
              vm.currentPageNum < totalPages
                  ? () => vm.goToPage(vm.currentPageNum + 1)
                  : null,
        ),
      ],
    );
  }
}

class ClassInfoDataSource extends DataGridSource {
  final VoidCallback onUpdated;

  ClassInfoDataSource({
    required List<ClassInfo> classInfoData,
    required this.onUpdated,
  }) {
    _classInfoData =
        classInfoData
            .map<DataGridRow>(
              (e) => DataGridRow(
                cells: [
                  DataGridCell<String>(columnName: 'id', value: e.id),
                  DataGridCell<String>(
                    columnName: 'classNumber',
                    value: e.classNumber,
                  ),
                  DataGridCell<String>(
                    columnName: 'createAt',
                    value: TimeUtil.formatTimestamp(e.createAt),
                  ),
                  const DataGridCell<String>(
                    columnName: 'operations',
                    value: '操作',
                  ),
                ],
              ),
            )
            .toList();
  }

  late List<DataGridRow> _classInfoData;

  @override
  List<DataGridRow> get rows => _classInfoData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final index = _classInfoData.indexOf(row);

    return DataGridRowAdapter(
      color: index.isEven ? Colors.grey[100] : Colors.white,
      cells:
          row.getCells().map<Widget>((e) {
            if (e.columnName == 'operations') {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClassEditBtn(
                    defaultClassNumber: _getValueByName(row, "classNumber"),
                    id: _getValueByName(row, "id"),
                    onUpdated: onUpdated,
                  ),

                  10.horizontalSpace,

                  ClassDeleteBtn(
                    id: _getValueByName(row, "id"),
                    onUpdated: onUpdated,
                  ),
                ],
              );
            }
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                e.value.toString(),
                style: TextStyle(
                  color: const Color(0xFF8D8D8D),
                  fontWeight: FontWeight.w300,
                ),
              ),
            );
          }).toList(),
    );
  }

  String _getValueByName(DataGridRow row, String name) {
    return row
        .getCells()
        .firstWhere((cell) => cell.columnName == name)
        .value
        .toString();
  }
}
