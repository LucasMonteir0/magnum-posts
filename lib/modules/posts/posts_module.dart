import "package:flutter_modular/flutter_modular.dart";

import "../commons/utils/config/routes.dart";
import "core/data/datasources/posts_datasource.dart";
import "core/data/datasources/posts_datasource_impl.dart";
import "core/data/repositories/posts_repository_impl.dart";
import "core/domain/repositories/posts_repository.dart";
import "core/domain/use_cases/get_author_by_id/get_author_by_id_use_case.dart";
import "core/domain/use_cases/get_author_by_id/get_author_by_id_use_case_impl.dart";
import "core/domain/use_cases/get_post_by_id/get_post_by_id_use_case.dart";
import "core/domain/use_cases/get_post_by_id/get_post_by_id_use_case_impl.dart";
import "core/domain/use_cases/get_posts/get_posts_use_case.dart";
import "core/domain/use_cases/get_posts/get_posts_use_case_impl.dart";
import "presentation/blocs/get_posts/get_posts_bloc.dart";
import "presentation/view/posts_view.dart";

class PostsModule extends Module {
  @override
  List<Bind> get binds => [
    // Datasources
    Bind.factory<PostsDatasource>((i) => PostsDatasourceImpl(i())),

    //Repostories
    Bind.factory<PostsRepository>((i) => PostsRepositoryImpl(i())),

    //UseCases
    Bind.factory<GetPostsUseCase>((i) => GetPostsUseCaseImpl(i())),
    Bind.factory<GetPostByIdUseCase>((i) => GetPostByIdUseCaseImpl(i())),
    Bind.factory<GetAuthorByIdUseCase>((i) => GetAuthorByIdUseCaseImpl(i())),

    //Blocs
    Bind.factory<GetPostsBloc>((i) => GetPostsBloc(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Routes.root, child: (_, _) => const PostsView()),
  ];
}
