import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/constants/route_constants.dart';
import 'package:myselff_flutter/app/core/database/local_database.dart';
import 'package:myselff_flutter/app/core/services/injection_service.dart';
import 'package:myselff_flutter/app/modules/expenses/data/datasource/local/expense/expense_local_data_source.dart';
import 'package:myselff_flutter/app/modules/expenses/data/datasource/local/expense/expense_local_data_source_impl.dart';
import 'package:myselff_flutter/app/modules/expenses/data/repository/expense_repository_impl.dart';
import 'package:myselff_flutter/app/modules/expenses/data/repository/payment_type_repository_impl.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/repository/expense_repository.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/usecase/expense_use_cases.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/expenses_list/expenses_list_controller.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/expenses_list/expenses_list_page.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/payment_method/payment_methods_controller.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/payment_method/payment_methods_page.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/save_expense/save_expense_controller.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/save_expense/save_expense_page.dart';

class ExpenseModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => SaveExpenseController(
            ExpensesRepositoryImpl(), PaymentMethodRepositoryImpl())),
        Bind<ExpenseLocalDataSource>(
            (i) => ExpenseLocalDataSourceImpl(i<LocalDatabase>())),
        Bind<ExpenseRepository>(
            (i) => ExpenseRepositoryImpl(i<ExpenseLocalDataSource>())),
        Bind.factory((i) => ExpensesListController(
              ExpensesRepositoryImpl(),
              PaymentMethodRepositoryImpl(),
              ExpenseUseCases(i<ExpenseRepository>()),
            )),
        Bind.factory(
            (i) => PaymentMethodsController(PaymentMethodRepositoryImpl())),
      ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        RouteConstants.initialRoute,
        child: (_, __) => ExpensesListPage(
          controller: Injector.of<ExpensesListController>(),
        ),
      ),
      ChildRoute(
        RouteConstants.formExpenseRoute,
        child: (_, args) => SaveExpensePage(
          controller: Injector.of<SaveExpenseController>(),
          expenseId: args.data != null ? args.data['expense_id'] : null,
        ),
      ),
      ChildRoute(
        RouteConstants.paymentTypeRoute,
        child: (_, __) => PaymentMethodsPage(
          controller: Injector.of<PaymentMethodsController>(),
        ),
      ),
    ];
  }
}
