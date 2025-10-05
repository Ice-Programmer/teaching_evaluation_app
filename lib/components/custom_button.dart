import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final double? iconGap;
  final Color? backgroundColor;
  final Color textColor;
  final double btnWidth;
  final double btnHeight;
  final double fontSize;
  final VoidCallback? onPressed;
  final double borderRadius;
  final bool isShadow;
  final FontWeight fontWeight;
  final bool disable;
  final Color? borderColor;

  const CustomButton({
    super.key,
    this.title,
    this.icon,
    this.iconGap,
    this.backgroundColor,
    this.onPressed,
    required this.textColor,
    required this.btnWidth,
    required this.btnHeight,
    required this.fontSize,
    this.borderRadius = 10,
    this.isShadow = true,
    this.fontWeight = FontWeight.bold,
    this.disable = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: btnHeight,
      width: btnWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: disable ? Colors.grey[400] : backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          boxShadow: (isShadow && backgroundColor != null)
              ? [
                  BoxShadow(
                    color: backgroundColor!.withOpacity(0.3),
                    spreadRadius: 2.r,
                    blurRadius: 5.r,
                    offset: Offset(0, 3.h),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: disable ? null : onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null)
                      Icon(
                        icon,
                        color: textColor,
                        size: fontSize,
                      ),
                    if (iconGap != null) iconGap!.horizontalSpace,
                    if (title != null)
                      Text(
                        title!,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          color: textColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
