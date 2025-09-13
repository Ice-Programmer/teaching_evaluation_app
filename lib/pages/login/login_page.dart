import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teaching_evaluation_app/common/assets.dart';
import 'package:teaching_evaluation_app/components/copyright_footer.dart';
import 'package:teaching_evaluation_app/components/custom_button.dart';
import 'package:teaching_evaluation_app/components/custom_input.dart';
import 'package:teaching_evaluation_app/model/login/user_login_request.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final UserLoginRequest _userLoginRequest = UserLoginRequest();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.assetsImagesLoginBackground,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getTitle(context),

                50.verticalSpace,

                _getInputFields(),

                50.verticalSpace,

                _getLoginButton(context),
              ],
            ),
          ),

          Align(alignment: Alignment.bottomCenter, child: CopyrightFooter()),
        ],
      ),
    );
  }

  Widget _getTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "学评教系统",
          style: TextStyle(
            fontSize: 35.sp,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _getInputFields() {
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入密码！';
              }
              return null;
            },
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
    // TokenVO tokenVO =
    //     await _authService.userPasswordLogin(_userPasswordLoginRequest);
    // 存储 token
    // String token = tokenVO.accessToken;
    // StoreUtil.saveToken(token);
    // LogUtils.println('登录成功，存储 token：$token');
    // ToastUtils.showSuccessMsg("登录成功！");
    // context.go("/forum");

    ToastUtils.showInfoMsg(_userLoginRequest.toJson().toString());
  }
}
