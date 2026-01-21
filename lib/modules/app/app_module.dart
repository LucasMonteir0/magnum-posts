import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:magnum_posts/modules/posts/posts_module.dart';

import '../commons/config/routes.dart';
import '../commons/core/data/services/http/http_service_impl.dart';
import '../commons/core/domain/services/http/http_service.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.lazySingleton<HttpService>((i) => HttpServiceImpl(Dio())),
  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute(Routes.posts, module: PostsModule()),
  ];
}
