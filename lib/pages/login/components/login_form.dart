import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:teaching_evaluation_app/components/custom_button.dart';
import 'package:teaching_evaluation_app/components/custom_input.dart';
import 'package:teaching_evaluation_app/model/login/user_info.dart';
import 'package:teaching_evaluation_app/model/login/user_login_request.dart';
import 'package:teaching_evaluation_app/model/login/user_login_response.dart';
import 'package:teaching_evaluation_app/service/login_service.dart';
import 'package:teaching_evaluation_app/utils/log_util.dart';
import 'package:teaching_evaluation_app/utils/store_util.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final UserLoginRequest _userLoginRequest = UserLoginRequest();

  final LoginService _loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_getLoginForm(), 50.verticalSpace, _getLoginButton(context)],
    );
  }

  Widget _getLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // 账号输入框
          CustomInput(
            width: 350.w,
            height: 60.h,
            hintText: "请输入账号",
            fontSize: 16.sp,
            onChanged:
                (userAccount) => _userLoginRequest.userAccount = userAccount,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入账号！';
              }
              return null;
            },
          ),

          30.verticalSpace,

          // 密码输入框
          CustomInput(
            width: 350.w,
            height: 60.h,
            hintText: "请输入密码",
            isPassword: true,
            fontSize: 16.sp,
            onChanged:
                (userPassword) => _userLoginRequest.userPassword = userPassword,
            validator: (v) => (v == null || v.isEmpty) ? "请输入密码！" : null,
          ),
        ],
      ),
    );
  }

  Widget _getLoginButton(BuildContext context) {
    return CustomButton(
      title: "登录",
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          _handleLogin(context);
        }
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Colors.white,
      isShadow: false,
      btnWidth: 250.w,
      btnHeight: 60.h,
      borderRadius: 30.r,
      fontSize: 20.sp,
    );
  }

  /// 处理登录逻辑
  Future<void> _handleLogin(BuildContext context) async {
    UserLoginResponse userLoginResponse = await _loginService.userPasswordLogin(
      _userLoginRequest,
    );
    String token = userLoginResponse.token!;
    StoreUtil.saveToken(token);
    LogUtils.println('登录成功，存储 token: $token');

    ToastUtils.showSuccessMsg("登录成功，欢迎回来 ${userLoginResponse.userInfo!.name}");

    if (context.mounted) {
      if (userLoginResponse.userInfo!.role == UserRole.admin) {
        context.go('/');
      }
    }
  }
}
