import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teaching_evaluation_app/common/assets.dart';
import 'package:teaching_evaluation_app/components/custom_button.dart';
import 'package:teaching_evaluation_app/components/custom_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                _getTitle(),

                50.verticalSpace,

                _getInputFields(),

                50.verticalSpace,

                _getLoginButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTitle() {
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
    return Column(
      children: [
        // 账号输入框
        CustomInput(
          width: 350.w,
          height: 60.h,
          hintText: "请输入账号",
          fontSize: 16.sp,
        ),

        30.verticalSpace,

        // 密码输入框
        CustomInput(
          width: 350.w,
          height: 60.h,
          hintText: "请输入密码",
          isPassword: true,
          fontSize: 16.sp,
        ),
      ],
    );
  }

  Widget _getLoginButton() {
    return CustomButton(
      title: "登录",
      onPressed: () {
        // _handleLogin(context);
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
}
