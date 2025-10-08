import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popover/popover.dart';
import 'package:teaching_evaluation_app/components/custom_button.dart';
import 'package:teaching_evaluation_app/model/student_class/delete/delete_student_class_request.dart';
import 'package:teaching_evaluation_app/service/class_service.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

class ClassDeleteBtn extends StatefulWidget {
  final String id;
  final VoidCallback? onUpdated;

  const ClassDeleteBtn({super.key, required this.id, this.onUpdated});

  @override
  State<ClassDeleteBtn> createState() => _ClassDeleteBtnState();
}

class _ClassDeleteBtnState extends State<ClassDeleteBtn> {
  final ClassService _classService = ClassService();
  late DeleteStudentClassRequest _deleteStudentClassRequest;

  @override
  void initState() {
    super.initState();
    _deleteStudentClassRequest = DeleteStudentClassRequest(id: widget.id);
  }

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

  Future<void> _deleteStudentClass() async {
    bool result = await _classService.deleteStudentClass(
      _deleteStudentClassRequest,
    );
    if (!mounted) return;

    if (result) {
      Navigator.pop(context);
      ToastUtils.showInfoMsg("删除班级信息成功");

      widget.onUpdated?.call();
    }
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
                    onPressed: () => _deleteStudentClass(),
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
