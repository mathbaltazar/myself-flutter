import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myself_flutter/app/core/theme/color_schemes.g.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'myself',
      theme: ThemeData(useMaterial3: true, colorScheme: MyselfTheme.lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: MyselfTheme.darkColorScheme),
    );
  }
}
