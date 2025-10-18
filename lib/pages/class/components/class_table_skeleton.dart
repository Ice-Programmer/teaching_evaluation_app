import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ClassTableSkeleton extends StatelessWidget {
  const ClassTableSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      highlightColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Column(
        children: [
          Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: Container(
                  height: 80.h,
                  margin: EdgeInsets.only(right: index != 3 ? 5.w : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey.shade300,
                  ),
                ),
              );
            }),
          ),

          20.verticalSpace,

          ...List.generate(6, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.grey.shade300,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
