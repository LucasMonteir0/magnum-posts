import "package:flutter/material.dart";

Widget runWidgetTest(Widget widget) => MaterialApp(
  home: Material(child: Scaffold(body: widget)),
);

Widget runPageTest(Widget widget) => MaterialApp(
  home: Material(child: SafeArea(child: widget)),
);
