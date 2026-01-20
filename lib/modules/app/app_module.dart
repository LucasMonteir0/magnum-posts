import 'package:flutter_modular/flutter_modular.dart';
import 'package:magnum_posts/modules/posts/posts_module.dart';

import '../commons/config/routes.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute(Routes.posts, module: PostsModule()),
  ];
}
