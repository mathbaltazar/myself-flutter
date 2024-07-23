import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/constants/route_constants.dart';
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
        RouteConstants.initialRoute,
        child: (_, __) => LoginPage(
          controller: Injector.of<LoginController>(),
        ),
      ),
    ];
  }
}
