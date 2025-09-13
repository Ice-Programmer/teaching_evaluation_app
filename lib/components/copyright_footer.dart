import 'package:flutter/material.dart';

/// 版权信息组件
class CopyrightFooter extends StatelessWidget {
  const CopyrightFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.transparent,
      child: Text(
        '© ${DateTime.now().year} 杭电圣光机联合学院-网络技术培训中心 版权所有',
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(
            context,
          ).colorScheme.inversePrimary.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}