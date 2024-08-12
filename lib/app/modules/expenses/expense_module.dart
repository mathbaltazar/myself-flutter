import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/app_module.dart';
import 'package:myselff_flutter/app/core/constants/route_constants.dart';
import 'package:myselff_flutter/app/core/services/injection_service.dart';

import 'data/datasource/local/expense/expense_local_data_source.dart';
import 'data/datasource/local/expense/expense_local_data_source_impl.dart';
import 'data/datasource/local/payment_type/payment_type_local_data_source.dart';
import 'data/datasource/local/payment_type/payment_type_local_data_source_impl.dart';
import 'data/repository/expense_repository_impl.dart';
import 'data/repository/payment_type_repository_impl.dart';
import 'domain/repository/expense_repository.dart';
import 'domain/repository/payment_type_repository.dart';
import 'domain/usecase/expense_use_cases.dart';
import 'domain/usecase/payment_type_use_cases.dart';
import 'presentation/controllers/expenses_list_controller.dart';
import 'presentation/controllers/payment_type_select_dialog_controller.dart';
import 'presentation/controllers/payment_types_controller.dart';
import 'presentation/pages/expenses_list_page.dart';
import 'presentation/pages/payment_types_page.dart';
import 'presentation/controllers/save_expense_controller.dart';
import 'presentation/pages/save_expense_page.dart';

class ExpenseModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ExpenseLocalDataSource>(ExpenseLocalDataSourceImpl.new);
    i.addSingleton<ExpenseRepository>(ExpenseRepositoryImpl.new);
    i.addSingleton<PaymentTypeLocalDataSource>(PaymentTypeLocalDataSourceImpl.new);
    i.addSingleton<PaymentTypeRepository>(PaymentTypeRepositoryImpl.new);
    i.addSingleton<ExpenseUseCases>(ExpenseUseCases.new);
    i.addSingleton<PaymentTypeUseCases>(PaymentTypeUseCases.new);
    i.add(ExpensesListController.new);
    i.add(PaymentTypesController.new);
    i.add(PaymentTypeSelectDialogController.new);
    i.add(SaveExpenseController.new);
  }

  @override
  void routes(r) {
    r.child(
      RouteConstants.initialRoute,
      child: (_) => ExpensesListPage(
        controller: InjectorService.of<ExpensesListController>(),
      ),
    );
    r.child(
      RouteConstants.formExpenseRoute,
      child: (_) => SaveExpensePage(
        controller: InjectorService.of<SaveExpenseController>(),
        expenseId: r.args.data?['expense_id'],
      ),
    );
    r.child(
      RouteConstants.paymentTypeRoute,
      child: (_) => PaymentTypesPage(
        controller: InjectorService.of<PaymentTypesController>(),
      ),
    );
  }

  @override
  List<Module> get imports => [
        AppModule(),
      ];
}
