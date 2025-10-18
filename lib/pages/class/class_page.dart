import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:teaching_evaluation_app/components/custom_pagination.dart';
import 'package:teaching_evaluation_app/pages/class/class_data_vm.dart';
import 'package:teaching_evaluation_app/pages/class/components/class_table.dart';
import 'package:teaching_evaluation_app/pages/class/components/class_header.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  final ClassDataViewModel _viewModel = ClassDataViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchClassInfoList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: SafeArea(
        minimum: EdgeInsets.all(20.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClassHeader(),
              20.verticalSpace,
              ClassTable(),
              20.verticalSpace,
              Consumer<ClassDataViewModel>(
                builder:
                    (context, vm, _) => CustomPagination(
                      total: vm.total,
                      pageSize: vm.currentPageSize,
                      size: 14,
                      onChange: (page, size) => vm.goToPage(page, size),
                      onPageSizeChange: (size) => vm.changePageSize(size),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
