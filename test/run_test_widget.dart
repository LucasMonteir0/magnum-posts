import "package:flutter/material.dart";
import "package:magnum_posts/modules/commons/utils/resources/theme/app_theme.dart";

Widget runWidgetTest(Widget widget) => MaterialApp(
  theme: AppTheme.lightTheme,
  home: Material(child: Scaffold(body: widget)),
);

Widget runPageTest(Widget widget) => MaterialApp(
  theme: AppTheme.lightTheme,
  home: Material(child: SafeArea(child: widget)),
);
