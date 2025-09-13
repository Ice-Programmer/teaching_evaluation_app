import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:teaching_evaluation_app/pages/login/login_page.dart';
import 'package:teaching_evaluation_app/pages/welcome_page.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

final GoRouter router = GoRouter(
  navigatorKey: ToastUtils.rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: '/', // 根路径
      name: '欢迎页',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: WelcomePage()),
    ),
    GoRoute(
      path: "/login",
      name: "登录页",
      pageBuilder: (context, state) => NoTransitionPage(child: LoginPage()),
    ),
  ],
);
