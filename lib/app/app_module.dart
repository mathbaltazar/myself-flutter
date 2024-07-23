import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/database/local_database.dart';
import 'package:myselff_flutter/app/modules/expenses/expense_module.dart';

import 'core/constants/route_constants.dart';
import 'modules/login/login_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.lazySingleton<LocalDatabase>((i) => LocalDatabase(), onDispose: (db) => db.close())
  ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          RouteConstants.initialRoute,
          module: LoginModule(),
        ),
        ModuleRoute(
          RouteConstants.expenseRoute,
          module: ExpenseModule(),
        ),
      ];
}
