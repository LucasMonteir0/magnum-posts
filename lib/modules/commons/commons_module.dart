import "package:cloud_firestore/cloud_firestore.dart";
import "package:dio/dio.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_modular/flutter_modular.dart";

import "core/data/services/http/http_service_impl.dart";
import "core/domain/services/http/http_service.dart";

class CommonsModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.instance<FirebaseAuth>(FirebaseAuth.instance, export: true),
    Bind.instance<FirebaseFirestore>(FirebaseFirestore.instance, export: true),
    Bind.factory<HttpService>((i) => HttpServiceImpl(Dio()), export: true),
  ];
}
