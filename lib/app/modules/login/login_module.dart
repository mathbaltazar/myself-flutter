import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/routes/app_routes.dart';
import 'package:myselff_flutter/app/core/services/injection_service.dart';

import 'presentation/controllers/login_controller.dart';
import 'presentation/pages/login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController()),
      ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        AppRoutes.initialRoute,
        child: (_, __) => LoginPage(
          controller: Injector.of<LoginController>(),
        ),
      ),
    ];
  }
}
