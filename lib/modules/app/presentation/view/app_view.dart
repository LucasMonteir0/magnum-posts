import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:magnum_posts/modules/commons/config/routes.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(Routes.posts);
    return MaterialApp.router(
      title: 'Magnum Posts',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
