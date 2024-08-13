import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/services/message_service.dart';
import 'package:myselff_flutter/app/core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = AppTheme.createTextTheme(context, "Raleway");
    AppTheme appTheme = AppTheme(textTheme);

    return MaterialApp.router(
      scaffoldMessengerKey: MessageService.instance,
      routerConfig: Modular.routerConfig,
      title: 'Myselff',
      theme: appTheme.light(),
      darkTheme: appTheme.dark(),
      highContrastTheme: appTheme.lightHighContrast(),
      highContrastDarkTheme: appTheme.darkHighContrast(),
    );
  }
}
