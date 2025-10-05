import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:teaching_evaluation_app/components/title_header.dart';
import 'package:teaching_evaluation_app/pages/class/class_page.dart';
import 'package:teaching_evaluation_app/pages/course/course_page.dart';
import 'package:teaching_evaluation_app/pages/evaluation/evaluation_page.dart';
import 'package:teaching_evaluation_app/pages/feedback/feedback_page.dart';
import 'package:teaching_evaluation_app/pages/score/score_page.dart';
import 'package:teaching_evaluation_app/pages/student/student_page.dart';
import 'package:teaching_evaluation_app/pages/target/target_page.dart';
import 'package:teaching_evaluation_app/pages/teacher/teacher_page.dart';
import 'package:teaching_evaluation_app/service/login_service.dart';
import 'package:teaching_evaluation_app/utils/log_util.dart';
import 'package:teaching_evaluation_app/utils/store_util.dart';

class AdminHomeLayout extends StatefulWidget {
  const AdminHomeLayout({super.key});

  @override
  State<AdminHomeLayout> createState() => _AdminhomelayoutState();
}

class _AdminhomelayoutState extends State<AdminHomeLayout> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  final LoginService _loginService = LoginService();

  // late List<SideMenuItemType> items;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();

    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_buildMenu(), _buildContent()],
      ),
    );
  }

  Widget _buildMenu() {
    return Expanded(
      flex: 1,
      child: SideMenu(
        style: SideMenuStyle(
          iconSize: 16.sp,
          backgroundColor: Colors.white,
          selectedTitleTextStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
          unselectedTitleTextStyle: TextStyle(fontSize: 12.sp),
          itemHeight: 40.sp, // 单个 item 高度
        ),
        controller: sideMenu,
        title: TitleHeader(),
        items: _buildMenuItems(sideMenu),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      flex: 4,
      child: Container(
        color: const Color(0xFFEFEFEF),
        padding: EdgeInsets.all(16.sp),
        child: Container(
          color: Colors.white, // PageView 内容区背景色（可选）
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              StudentPage(),
              ClassPage(),
              TeacherPage(),
              CoursePage(),
              EvaluationPage(),
              TargetPage(),
              FeedbackPage(),
              ScorePage(),
            ],
          ),
        ),
      ),
    );
  }

  List<SideMenuItemType> _buildMenuItems(SideMenuController sideMenu) {
    return [
      SideMenuItem(
        title: '学生管理',
        icon: const Icon(Icons.school),
        onTap: (index, _) => sideMenu.changePage(index),
      ),
      SideMenuItem(
        title: '班级管理',
        icon: const Icon(Icons.class_rounded),
        onTap: (index, _) => sideMenu.changePage(index),
      ),
      SideMenuItem(
        title: '教师管理',
        icon: const Icon(Icons.person_outline),
        onTap: (index, _) => sideMenu.changePage(index),
      ),
      SideMenuItem(
        title: '课程管理',
        icon: const Icon(Icons.menu_book),
        onTap: (index, _) => sideMenu.changePage(index),
      ),
      SideMenuItem(
        title: '发布评测',
        icon: const Icon(Icons.assignment_outlined),
        onTap: (index, _) => sideMenu.changePage(index),
      ),
      SideMenuItem(
        title: '评价体系',
        icon: const Icon(Icons.rule),
        onTap: (index, _) => sideMenu.changePage(index),
      ),
      SideMenuItem(
        title: '意见反馈',
        icon: const Icon(Icons.feedback_outlined),
        onTap: (index, _) => sideMenu.changePage(index),
      ),
      SideMenuItem(
        title: '评教结果',
        icon: const Icon(Icons.bar_chart),
        onTap: (index, _) => sideMenu.changePage(index),
      ),
    ];
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
