import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  }, (error, stack) {
    print('MYSELF-FLUTTER error > $error');
    print('MYSELF-FULTTER stack > $stack');
  });
}