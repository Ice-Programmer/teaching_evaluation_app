import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teaching_evaluation_app/pages/class/components/class_table.dart';
import 'package:teaching_evaluation_app/pages/class/components/class_header.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(20.sp),
      child: Column(children: [ClassHeader(), 40.verticalSpace, ClassTable()]),
    );
  }
}
