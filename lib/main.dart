import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myselff/app/core/database/local_database.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'firebase_options.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Animate.restartOnHotReload = true;

    await initializeDateFormatting('pt_BR', null);

    await LocalDatabase.initialize();
    
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  }, (error, stack) {
    debugPrint('MYSELFF-FLUTTER error > $error');
    debugPrint('MYSELFF-FLUTTER stack > $stack');
  });
}