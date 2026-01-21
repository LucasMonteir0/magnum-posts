import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";
import "../../../commons/config/routes.dart";
import "../../../commons/utils/resources/theme/app_theme.dart";

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(Routes.posts);
    return MaterialApp.router(
      title: "Magnum Posts",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
