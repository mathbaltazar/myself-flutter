import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/constants/route_constants.dart';
import 'package:myselff_flutter/app/core/services/injection_service.dart';

import 'presentation/controllers/login_controller.dart';
import 'presentation/pages/login_page.dart';

class LoginModule extends Module {
  @override
  void binds(i) {
      i.add(LoginController.new);
  }

  @override
  void routes(r) {
      r.child(
        RouteConstants.initialRoute,
        child: (_) => LoginPage(
          controller: InjectorService.of<LoginController>(),
        ),
      );
  }
}
