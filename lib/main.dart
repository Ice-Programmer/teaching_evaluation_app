import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:teaching_evaluation_app/app.dart';
import 'package:teaching_evaluation_app/theme/theme_provider.dart';

void main() {
  // 设置URL路径策略，确保在Web环境中正确处理路径，去除URL中的#符号
  usePathUrlStrategy();
  SmartDialog.config
    ..custom = SmartConfigCustom(
      maskColor: Colors.black.withOpacity(0.35),
      useAnimation: false,
    )
    ..attach = SmartConfigAttach(
      animationType: SmartAnimationType.scale,
      usePenetrate: false,
    )
    ..loading = SmartConfigLoading(
      clickMaskDismiss: false,
      leastLoadingTime: const Duration(milliseconds: 0),
    )
    ..toast = SmartConfigToast(
      intervalTime: const Duration(milliseconds: 100),
      displayTime: const Duration(milliseconds: 100),
    );

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
