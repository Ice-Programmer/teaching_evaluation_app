import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teaching_evaluation_app/service/login_service.dart';
import 'package:teaching_evaluation_app/utils/log_util.dart';
import 'package:teaching_evaluation_app/utils/store_util.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final LoginService _loginService = LoginService();
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Welcome!"));
  }

  // 单独的异步方法
  Future<void> _checkLoginStatus() async {
    // 判断是否登录
    String? token = await StoreUtil.getToken();
    // 检查当前组件是否仍然挂载
    if (token == null && mounted) {
      context.go("/login");
    }

    try {
      // 通过后端接口获取当前登录用户信息，验证 token 是否有效
      final userResponse = await _loginService.getCurrentLoginUser();
      if (!mounted) return;

      if (userResponse.userInfo == null) {
        context.go("/login");
        return;
      }

      LogUtils.println("当前登录用户: ${userResponse.userInfo?.name}");
    } catch (e) {
      if (!mounted) return;
      context.go("/login");
    }
  }
}
