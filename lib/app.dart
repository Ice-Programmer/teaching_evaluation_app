import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:teaching_evaluation_app/http/dio_instance.dart';
import 'package:teaching_evaluation_app/route/routes.dart';
import 'package:teaching_evaluation_app/theme/dark_theme.dart';
import 'package:teaching_evaluation_app/theme/theme_provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    DioInstance.instance().initDio();
  }

  Size _calcDesignSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final logicalShortestSize = mediaQuery.size.shortestSide;
    final logicalLongestSize = mediaQuery.size.longestSide;
    const scaleFactor = 0.95;
    return Size(
      logicalShortestSize * scaleFactor,
      logicalLongestSize * scaleFactor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final designSize = _calcDesignSize(context);
        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              theme:
                  Provider.of<ThemeProvider>(context, listen: true).themeData,
              darkTheme: darkMode,
              builder: (context, child) {
                return FlutterSmartDialog(child: child);
              },
            );
          },
        );
      },
    );
  }
}
