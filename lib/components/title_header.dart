import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teaching_evaluation_app/common/assets.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.assetsImagesTitle),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "学评教系统",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w900,
                // color: Theme.of(context).colorScheme.primary,
                color: const Color(0xFF184687),
              ),
            ),

            10.horizontalSpace,

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.h,
                vertical: 4.w,
              ), // 内边距
              decoration: BoxDecoration(
                color: const Color(0xFFFF555D), // 背景色
                borderRadius: BorderRadius.circular(999.r), // 圆角
              ),
              child: Text(
                '管理端',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        20.verticalSpace,
      ],
    );
  }
}
