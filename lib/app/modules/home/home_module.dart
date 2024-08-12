import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/constants/route_constants.dart';
import 'package:myselff_flutter/app/core/services/injection_service.dart';
import 'package:myselff_flutter/app/modules/expenses/expense_module.dart';
import 'package:myselff_flutter/app/modules/home/presentation/controllers/home_page_controller.dart';
import 'package:myselff_flutter/app/modules/home/presentation/pages/home_page.dart';
import 'package:myselff_flutter/app/modules/user/user_module.dart';

class HomeModule extends Module {

@override
  void binds(Injector i) {
    i.add(HomePageController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      RouteConstants.initialRoute,
      child: (_) => HomePage(controller: InjectorService.of<HomePageController>()),
      children: [
        ParallelRoute.module(RouteConstants.expenseRoute, module: ExpenseModule()),
        ParallelRoute.module(RouteConstants.userRoute, module: UserModule()),
      ]
    );
  }
}
