import "package:cloud_firestore/cloud_firestore.dart";
import "package:dio/dio.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_modular/flutter_modular.dart";

import "core/data/datasources/sign_out_datasource.dart";
import "core/data/datasources/sign_out_datasource_impl.dart";
import "core/data/repositories/sign_out_repository_impl.dart";
import "core/data/services/http/http_service_impl.dart";
import "core/domain/repositories/sign_out_repository.dart";
import "core/domain/services/http/http_service.dart";
import "core/domain/use_cases/sign_out/sign_out_use_case.dart";
import "core/domain/use_cases/sign_out/sign_out_use_case_impl.dart";
import "presentation/blocs/sign_out_bloc.dart";

class CommonsModule extends Module {
  @override
  List<Bind> get binds => [
    // Firebase instances
    Bind.instance<FirebaseAuth>(FirebaseAuth.instance, export: true),
    Bind.instance<FirebaseFirestore>(FirebaseFirestore.instance, export: true),

    // Http Service
    Bind.lazySingleton<HttpService>(
      (i) => HttpServiceImpl(Dio()),
      export: true,
    ),

    // SignOut - Datasources
    Bind.factory<SignOutDataSource>(
      (i) => SignOutDataSourceImpl(i()),
      export: true,
    ),

    // SignOut - Repositories
    Bind.factory<SignOutRepository>(
      (i) => SignOutRepositoryImpl(i()),
      export: true,
    ),

    // SignOut - UseCases
    Bind.factory<SignOutUseCase>((i) => SignOutUseCaseImpl(i()), export: true),

    // SignOut - Blocs
    Bind.factory<SignOutBloc>((i) => SignOutBloc(i()), export: true),
  ];
}
