import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teaching_evaluation_app/common/assets.dart';
import 'package:teaching_evaluation_app/components/copyright_footer.dart';
import 'package:teaching_evaluation_app/pages/login/components/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              children: [_getTitle(context), 50.verticalSpace, LoginForm()],
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
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
