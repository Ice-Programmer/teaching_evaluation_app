import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teaching_evaluation_app/components/custom_button.dart';

class ClassExcelImportBtn extends StatefulWidget {
  final VoidCallback? onUpdated;

  const ClassExcelImportBtn({super.key, this.onUpdated});

  @override
  State<ClassExcelImportBtn> createState() => _ClassExcelImportBtnState();
}

class _ClassExcelImportBtnState extends State<ClassExcelImportBtn> {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      textColor: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.primary,
      btnWidth: 80.w,
      btnHeight: 75.h,
      fontSize: 10.sp,
      title: "Excel 导入",
      onPressed: () => {},
    );
  }
}
