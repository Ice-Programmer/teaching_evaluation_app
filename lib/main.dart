import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:teaching_evaluation_app/app.dart';
import 'package:teaching_evaluation_app/theme/theme_provider.dart';

void main() {
  // 设置URL路径策略，确保在Web环境中正确处理路径，去除URL中的#符号
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProxyProvider(
          create: (content) => ThemeProvider(),
          update: (context, settingsProvider, themeProvider) {
            return ThemeProvider(); // 返回原始的 themeProvider 实例
          },
        ),
      ],
      child: const App(),
    ),
  );
}
