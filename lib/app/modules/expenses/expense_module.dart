import 'package:flutter_modular/flutter_modular.dart';
import 'package:myself_flutter/app/core/constants/app_routes.dart';
import 'package:myself_flutter/app/core/services/injection_service.dart';
import 'package:myself_flutter/app/modules/expenses/domain/repository/expenses_repository.dart';
import 'package:myself_flutter/app/modules/expenses/presentation/add_edit_expense/save_expense_controller.dart';
import 'package:myself_flutter/app/modules/expenses/presentation/add_edit_expense/save_expense_page.dart';
import 'package:myself_flutter/app/modules/expenses/presentation/expenses_list/expenses_list_controller.dart';
import 'package:myself_flutter/app/modules/expenses/presentation/expenses_list/expenses_list_page.dart';

class ExpenseModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
            (i) => SaveExpenseController(/*i<ExpensesRepository>()*/)),
        Bind((i) => ExpensesListController(/*i<ExpensesRepository>()*/)),
      ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        AppRoutes.initialRoute,
        child: (_, __) => ExpensesListPage(
          controller: DependencyProvider.of<ExpensesListController>(),
        ),
      ),
      ChildRoute(
        AppRoutes.saveExpense,
        child: (_, args) => SaveExpensePage(
          controller: DependencyProvider.of<SaveExpenseController>(),
          expenseId: args.data != null ? args.data['id'] : null,
        ),
      ),
    ];
  }
}
