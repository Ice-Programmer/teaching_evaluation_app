import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:teaching_evaluation_app/components/custom_button.dart';
import 'package:teaching_evaluation_app/components/custom_input.dart';
import 'package:teaching_evaluation_app/model/student_class/create/create_student_class_request.dart';
import 'package:teaching_evaluation_app/service/class_service.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

class ClassCreateBtn extends StatefulWidget {
  final VoidCallback? onUpdated;
  const ClassCreateBtn({super.key, this.onUpdated});

  @override
  State<ClassCreateBtn> createState() => _ClassCreateBtnState();
}

class _ClassCreateBtnState extends State<ClassCreateBtn> {
  final _formKey = GlobalKey<FormState>();
  final ClassService _classService = ClassService();
  final CreateStudentClassRequest _createStudentClassRequest =
      CreateStudentClassRequest();

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      textColor: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.primary,
      btnWidth: 80.w,
      btnHeight: 75.h,
      fontSize: 10.sp,
      title: "添加班级",
      onPressed: _showCreateDialog,
    );
  }

  void _showCreateDialog() {
    SmartDialog.show(
      builder: (_) {
        return IntrinsicWidth(
          child: IntrinsicHeight(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: _buildCreateModal(),
            ),
          ),
        );
      },
    );
  }

  Future<void> _createStudentClass() async {
    bool result = await _classService.createStudentClass(
      _createStudentClassRequest,
    );
    if (result) {
      SmartDialog.dismiss(force: true);
      ToastUtils.showInfoMsg("创建班级信息成功");

      if (widget.onUpdated != null) {
        widget.onUpdated!();
      }
    }
  }

  Widget _buildCreateModal() {
    return SafeArea(
      minimum: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "创建班级",
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            40.verticalSpace,

            Text(
              "班级编号",
              style: TextStyle(
                color: Colors.black,
                fontSize: 8.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            8.verticalSpace,

            CustomInput(
              height: 40,
              hintText: "请输入班级编号",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "班级编号不能为空";
                }
                return null;
              },
              borderColor: Colors.grey.withAlpha(100),
              onChanged: (value) {
                _createStudentClassRequest.classNumber = value;
              },
              backgroundColor: Colors.white,
            ),

            40.verticalSpace,

            Row(
              children: [
                100.horizontalSpace,
                CustomButton(
                  textColor: Colors.black,
                  borderColor: Colors.grey.withAlpha(100),
                  btnWidth: 80,
                  btnHeight: 38,
                  fontSize: 12,
                  title: "取消",
                  isShadow: false,
                  onPressed: () => {SmartDialog.dismiss(force: true)},
                ),

                8.horizontalSpace,

                CustomButton(
                  textColor: Colors.white,
                  isShadow: false,
                  backgroundColor: const Color(0xFF1677FF),
                  btnWidth: 80,
                  btnHeight: 38,
                  fontSize: 12,
                  title: "确认",
                  onPressed: _createStudentClass,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
