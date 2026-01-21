import "package:flutter_modular/flutter_modular.dart";

import "../commons/utils/config/routes.dart";
import "core/data/datarources/auth_datasource.dart";
import "core/data/datarources/auth_datasource_impl.dart";
import "core/data/repositories/auth_repository_impl.dart";
import "core/domain/repositories/auth_repository.dart";
import "core/domain/use_cases/sign_in/sign_in_use_case.dart";
import "core/domain/use_cases/sign_in/sign_in_use_case_impl.dart";
import "presentation/blocs/sign_in_bloc.dart";
import "presentation/views/sign_in_view.dart";

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
    //Datasources
    Bind.factory<AuthDataSource>((i) => AuthDataSourceImpl(i())),

    //Repositories
    Bind.factory<AuthRepository>((i) => AuthRepositoryImpl(i())),

    //UseCases
    Bind.factory<SignInUseCase>((i) => SignInUseCaseImpl(i())),

    //Blocs
    Bind.factory<SignInBloc>((i) => SignInBloc(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Routes.signIn, child: (context, args) => const SignInView()),
  ];
}
