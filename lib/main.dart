import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

import "modules/app/app_module.dart";
import "modules/app/presentation/view/app_view.dart";
import "modules/commons/utils/cache/app_cache.dart";
import "modules/commons/utils/config/firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppCache.instance.init();
  runApp(ModularApp(module: AppModule(), child: const AppView()));
}
