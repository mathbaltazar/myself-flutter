import 'package:flutter_modular/flutter_modular.dart';

import 'core/constants/route_constants.dart';
import 'core/database/local_database.dart';
import 'modules/expenses/expense_module.dart';
import 'modules/login/login_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<LocalDatabase>(LocalDatabase.new,
        config: BindConfig(
          onDispose: (db) => db.close(),
        ));
  }

  @override
  void routes(r) {
    r.module(
      RouteConstants.initialRoute,
      module: LoginModule(),
    );
    r.module(
      RouteConstants.expenseRoute,
      module: ExpenseModule(),
    );
  }
}
