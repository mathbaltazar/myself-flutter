import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff/app/core/constants/route_constants.dart';
import 'package:signals/signals.dart';

class HomePageController {
  final selectedPage = signal(0);

  selectPage(int page) {
    selectedPage.set(page);

    switch (page) {
      case 0:
        Modular.to.navigate(RouteConstants.expenseRoute);
        break;
      case 1:
        Modular.to.navigate(RouteConstants.userRoute);
        break;
    }

  }
}
