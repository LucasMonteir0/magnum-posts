import 'package:flutter_modular/flutter_modular.dart';
import 'package:magnum_posts/modules/posts/presentation/view/posts_view.dart';

class PostsModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/", child: (_, _) => const PostsView()),
  ];
}
