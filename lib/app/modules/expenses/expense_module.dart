import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/routes/app_routes.dart';
import 'package:myselff_flutter/app/core/services/injection_service.dart';
import 'package:myselff_flutter/app/modules/expenses/data/repository/expenses_repository_impl.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/repository/expenses_repository.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/save_expense/save_expense_controller.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/save_expense/save_expense_page.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/expenses_list/expenses_list_controller.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/expenses_list/expenses_list_page.dart';

class ExpenseModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<ExpensesRepository>((i) => ExpensesRepositoryImpl()),
        Bind.factory((i) => SaveExpenseController(i<ExpensesRepository>())),
        Bind.factory((i) => ExpensesListController(i<ExpensesRepository>())),
      ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        AppRoutes.initialRoute,
        child: (_, __) => ExpensesListPage(
          controller: Injector.of<ExpensesListController>(),
        ),
      ),
      ChildRoute(
        AppRoutes.saveExpense,
        child: (_, args) => SaveExpensePage(
          controller: Injector.of<SaveExpenseController>(),
          expenseId: args.data != null ? args.data['expense_id'] : null,
        ),
      ),
    ];
  }
}
