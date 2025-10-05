import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teaching_evaluation_app/components/custom_button.dart';
import 'package:teaching_evaluation_app/components/custom_input.dart';

class ClassHeader extends StatefulWidget {
  const ClassHeader({super.key});

  @override
  State<ClassHeader> createState() => _ClassHeaderState();
}

class _ClassHeaderState extends State<ClassHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSearchField(),
        40.horizontalSpace,
        _buildButtons(context),
      ],
    );
  }

  Widget _buildSearchField() {
    return Expanded(
      flex: 4,
      child: CustomInput(
        height: 75.h,
        hintText: "请输入班级名称或班级编号",
        prefixIcon: Icons.search,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              textColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.primary,
              btnWidth: 80.w,
              btnHeight: 75.h,
              fontSize: 8.sp,
              title: "添加班级",
              onPressed: () => {},
            ),
          ),

          10.horizontalSpace,

          Expanded(
            child: CustomButton(
              textColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.primary,
              btnWidth: 80.w,
              btnHeight: 75.h,
              fontSize: 8.sp,
              title: "Excel 导入",
              onPressed: () => {},
            ),
          ),
        ],
      ),
    );
  }
}
