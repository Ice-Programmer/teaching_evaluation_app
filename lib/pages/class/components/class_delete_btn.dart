import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popover/popover.dart';
import 'package:teaching_evaluation_app/components/custom_button.dart';

class ClassDeleteBtn extends StatelessWidget {
  const ClassDeleteBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      textColor: Colors.white,
      btnWidth: 60,
      btnHeight: 36,
      borderRadius: 0,
      fontSize: 15,
      title: "删除",
      isShadow: false,
      backgroundColor: Colors.redAccent,
      onPressed:
          () => {
            showPopover(
              context: context,
              bodyBuilder: _buildPopContent,
              direction: PopoverDirection.top,
              arrowHeight: 15,
              arrowWidth: 30,
              barrierColor: Colors.transparent,
            ),
          },
    );
  }

  Widget _buildPopContent(BuildContext context) {
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: SafeArea(
          minimum: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.error_rounded, size: 14, color: Colors.amber),
                  5.horizontalSpace,
                  Text(
                    "确认删除班级操作？",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    textColor: Colors.black,
                    borderColor: Colors.grey.withAlpha(100),
                    btnWidth: 60,
                    btnHeight: 28,
                    borderRadius: 2.r,
                    fontSize: 12,
                    title: "No",
                    isShadow: false,
                    onPressed: () => {Navigator.pop(context)},
                  ),

                  8.horizontalSpace,

                  CustomButton(
                    textColor: Colors.white,
                    isShadow: false,
                    backgroundColor: const Color(0xFF1F41BB),
                    btnWidth: 60,
                    btnHeight: 28,
                    borderRadius: 2.r,
                    fontSize: 12,
                    title: "Yes",
                    onPressed: () => {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
