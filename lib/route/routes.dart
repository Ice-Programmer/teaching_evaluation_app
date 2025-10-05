import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:teaching_evaluation_app/layouts/admin_home_layout.dart';
import 'package:teaching_evaluation_app/pages/login/login_page.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

final GoRouter router = GoRouter(
  navigatorKey: ToastUtils.rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: '/', // 根路径
      redirect: (context, state) => '/admin/home', // 直接重定向
    ),
    GoRoute(
      path: "/login",
      name: "登录页",
      pageBuilder: (context, state) => NoTransitionPage(child: LoginPage()),
    ),
    GoRoute(
      path: '/admin/home',
      name: '首页',
      pageBuilder:
          (context, state) => NoTransitionPage(child: AdminHomeLayout()),
    ),
  ],
);
