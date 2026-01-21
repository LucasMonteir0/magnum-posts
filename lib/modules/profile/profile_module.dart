import "package:flutter_modular/flutter_modular.dart";

import "../commons/commons_module.dart";
import "../commons/utils/config/routes.dart";
import "core/data/datasources/profile_datasource.dart";
import "core/data/datasources/profile_datasource_impl.dart";
import "core/data/repositories/profile_repository_impl.dart";
import "core/domain/repositories/profile_repository.dart";
import "core/domain/user_cases/get_profile/get_profile_use_case.dart";
import "core/domain/user_cases/get_profile/get_profile_use_case_impl.dart";
import "presentation/blocs/get_profile_bloc.dart";
import "presentation/views/profile_view.dart";

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [
    //Datasources
    Bind.factory<ProfileDataSource>((i) => ProfileDataSourceImpl(i())),

    // Repositories
    Bind.factory<ProfileRepository>((i) => ProfileRepositoryImpl(i())),

    // UseCases
    Bind.factory<GetProfileUseCase>((i) => GetProfileUseCaseImpl(i())),

    //Blocs
    Bind.factory<GetProfileBloc>((i) => GetProfileBloc(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Routes.root, child: (_, _) => const ProfileView()),
  ];

  @override
  List<Module> get imports => [CommonsModule()];
}
