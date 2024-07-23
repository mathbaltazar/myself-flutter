import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/constants/route_constants.dart';
import 'package:myselff_flutter/app/core/database/local_database.dart';
import 'package:myselff_flutter/app/core/services/injection_service.dart';
import 'package:myselff_flutter/app/modules/expenses/data/datasource/local/expense/expense_local_data_source.dart';
import 'package:myselff_flutter/app/modules/expenses/data/datasource/local/expense/expense_local_data_source_impl.dart';
import 'package:myselff_flutter/app/modules/expenses/data/datasource/local/payment_type/payment_type_local_data_source.dart';
import 'package:myselff_flutter/app/modules/expenses/data/datasource/local/payment_type/payment_type_local_data_source_impl.dart';
import 'package:myselff_flutter/app/modules/expenses/data/repository/expense_repository_impl.dart';
import 'package:myselff_flutter/app/modules/expenses/data/repository/payment_type_repository_impl.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/repository/expense_repository.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/repository/payment_type_repository.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/usecase/expense_use_cases.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/usecase/payment_type_use_cases.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/controllers/expenses_list_controller.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/controllers/payment_type_select_dialog_controller.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/controllers/payment_types_controller.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/pages/expenses_list_page.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/pages/payment_types_page.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/controllers/save_expense_controller.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/pages/save_expense_page.dart';

class ExpenseModule extends Module {
  @override
  List<Bind> get binds =>
      [
        Bind<ExpenseLocalDataSource>(
            (i) => ExpenseLocalDataSourceImpl(i<LocalDatabase>())),
        Bind<ExpenseRepository>(
            (i) => ExpenseRepositoryImpl(i<ExpenseLocalDataSource>())),
        Bind<PaymentTypeLocalDataSource>(
            (i) => PaymentTypeLocalDataSourceImpl(i<LocalDatabase>())),
        Bind<PaymentTypeRepository>(
            (i) => PaymentTypeRepositoryImpl(i<PaymentTypeLocalDataSource>())),
        Bind<ExpenseUseCases>((i) => ExpenseUseCases(i<ExpenseRepository>())),
        Bind<PaymentTypeUseCases>((i) => PaymentTypeUseCases(i<PaymentTypeRepository>())),
        Bind.factory((i) =>
            ExpensesListController(ExpenseUseCases(i<ExpenseRepository>()))),
        Bind.factory((i) => PaymentTypesController(i<PaymentTypeUseCases>())),
        Bind.factory((i) => PaymentTypeSelectDialogController(i<PaymentTypeUseCases>())),
        Bind.factory((i) => SaveExpenseController(i<ExpenseUseCases>(), i<PaymentTypeUseCases>())),
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
        child: (_, __) => PaymentTypesPage(
          controller: Injector.of<PaymentTypesController>(),
        ),
      ),
    ];
  }
}
