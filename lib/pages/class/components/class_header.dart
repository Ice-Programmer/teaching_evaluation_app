import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:teaching_evaluation_app/components/custom_input.dart';
import 'package:teaching_evaluation_app/pages/class/class_data_vm.dart';
import 'package:teaching_evaluation_app/pages/class/components/class_create_btn.dart';
import 'package:teaching_evaluation_app/pages/class/components/class_excel_import_btn.dart';

class ClassHeader extends StatefulWidget {
  const ClassHeader({super.key});

  @override
  State<ClassHeader> createState() => _ClassHeaderState();
}

class _ClassHeaderState extends State<ClassHeader> {
  String _searchText = "";
  @override
  Widget build(BuildContext context) {
    final vm = context.read<ClassDataViewModel>();
    return Row(
      children: [
        _buildSearchField(vm),
        80.horizontalSpace,
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(child: ClassCreateBtn(onUpdated: vm.refresh)),

              10.horizontalSpace,

              Expanded(child: ClassExcelImportBtn(onUpdated: vm.refresh)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(ClassDataViewModel vm) {
    return Expanded(
      flex: 4,
      child: CustomInput(
        height: 75.h,
        hintText: "请输入班级名称或班级编号",
        suffixIcon: Icons.search,
        onChanged: (value) => {setState(() {
          _searchText = value;
        })},
        onSuffixTap: () => vm.search(_searchText),
      ),
    );
  }
}
