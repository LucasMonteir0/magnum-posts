import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_modular/flutter_modular.dart";

import "../cache/app_cache.dart";
import "../config/routes.dart";

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: Routes.auth + Routes.signIn);

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final user = Modular.get<FirebaseAuth>().currentUser;
    final userId = AppCache.instance.getUserId();

    if (userId == null && user?.uid != null) {
      await AppCache.instance.saveUserId(user!.uid);
    }

    return user != null;
  }
}
