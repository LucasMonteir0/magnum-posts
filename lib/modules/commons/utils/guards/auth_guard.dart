import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_modular/flutter_modular.dart";

import "../config/routes.dart";

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: Routes.auth + Routes.signIn);

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    final user = Modular.get<FirebaseAuth>().currentUser;
    return user != null;
  }
}
