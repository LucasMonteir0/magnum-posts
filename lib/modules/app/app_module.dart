import "package:flutter_modular/flutter_modular.dart";

import "../auth/auth_module.dart";
import "../commons/commons_module.dart";
import "../commons/utils/config/routes.dart";
import "../commons/utils/guards/auth_guard.dart";
import "../posts/posts_module.dart";
import "../profile/profile_module.dart";

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute(Routes.auth, module: AuthModule()),
    ModuleRoute(Routes.posts, module: PostsModule(), guards: [AuthGuard()]),
    ModuleRoute(Routes.profile, module: ProfileModule(), guards: [AuthGuard()]),
  ];

  @override
  List<Module> get imports => [CommonsModule()];
}
