import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myselff_flutter/app/core/services/message_service.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: MessageService.instance(context),
      routerConfig: Modular.routerConfig,
      title: 'myselff',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: MyselffTheme.lightColorScheme,
        textTheme: GoogleFonts.montserratTextTheme()
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: MyselffTheme.darkColorScheme,
      ),
    );
  }
}
