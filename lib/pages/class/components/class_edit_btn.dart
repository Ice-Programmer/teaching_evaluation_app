import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:teaching_evaluation_app/components/custom_button.dart';
import 'package:teaching_evaluation_app/components/custom_input.dart';
import 'package:teaching_evaluation_app/model/student_class/edit/edit_student_request.dart';
import 'package:teaching_evaluation_app/service/class_service.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

class ClassEditBtn extends StatefulWidget {
  final String id;
  final String defaultClassNumber;
  final VoidCallback? onUpdated;

  const ClassEditBtn({
    super.key,
    required this.defaultClassNumber,
    required this.id,
    this.onUpdated,
  });

  @override
  State<ClassEditBtn> createState() => _ClassEditBtnState();
}

class _ClassEditBtnState extends State<ClassEditBtn> {
  final _formKey = GlobalKey<FormState>();

  final ClassService _classService = ClassService();
  late EditStudentClassRequest _editStudentClassRequest;

  @override
  void initState() {
    super.initState();
    _editStudentClassRequest = EditStudentClassRequest(
      id: widget.id,
      classNumber: widget.defaultClassNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      textColor: Colors.white,
      btnWidth: 60,
      btnHeight: 36,
      borderRadius: 0,
      fontSize: 15,
      title: "编辑",
      isShadow: false,
      backgroundColor: const Color(0xFF1F41BB),
      onPressed: () => _showCreateDialog(context),
    );
  }

  void _showCreateDialog(BuildContext context) {
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
              child: _buildCreateModal(context),
            ),
          ),
        );
      },
    );
  }

  Future<void> _editStudentClass() async {
    bool result = await _classService.editStudentClass(
      _editStudentClassRequest,
    );
    if (result) {
      SmartDialog.dismiss(force: true);
      ToastUtils.showInfoMsg("更新班级信息成功");

      if (widget.onUpdated != null) {
        widget.onUpdated!();
      }
    }
  }

  Widget _buildCreateModal(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "编辑班级",
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
              defaultValue: widget.defaultClassNumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "班级编号不能为空";
                }
                return null;
              },
              borderColor: Colors.grey.withAlpha(100),
              onChanged: (value) {
                _editStudentClassRequest.classNumber = value;
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _editStudentClass();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
