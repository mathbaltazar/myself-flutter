import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff/app/core/constants/route_constants.dart';
import 'package:myselff/app/core/extensions/list_extensions.dart';
import 'package:myselff/app/core/extensions/signals_extensions.dart';
import 'package:myselff/app/core/services/message_service.dart';
import 'package:myselff/app/modules/expenses/domain/entity/expense_entity.dart';
import 'package:myselff/app/modules/expenses/domain/entity/payment_type_entity.dart';
import 'package:myselff/app/modules/expenses/domain/usecase/expense_use_cases.dart';
import 'package:signals/signals.dart';

class ExpensesListController {
  ExpensesListController(this.expenseUseCases);

  final ExpenseUseCases expenseUseCases;

  late final totalExpensesAmount = computed(() => expensesList.fold(
      0.0, (previousValue, element) => previousValue + element.amount));
  late final totalPaidExpensesAmount = computed(() => expensesList
      .where((element) => element.paid)
      .fold(0.0, (previousValue, element) => previousValue + element.amount));
  late final totalUnpaid = computed(() => totalExpensesAmount.get() - totalPaidExpensesAmount.get());

  final currentDate = signal(DateTime.now());
  final expensesList = listSignal<ExpenseEntity>([]);
  final selectedExpense = signal<ExpenseEntity?>(null);

  getExpenses() async {
    // call to retrieve the expenses by their year and month
    // if error, show a message
    // if success, set the result to the expense state object list
    final result = await expenseUseCases.getExpensesByYearMonth(
      year: currentDate.get().year,
      month: currentDate.get().month,
    );

    result.fold(
      (error) {
        MessageService.showErrorMessage(error.message);
        debugPrint('_ExpensesListController.getExpenses >> ${error.message}');
      },
      (items) {
        expensesList.set(items);
        selectedExpense.set(items
            .where((element) => element.id == selectedExpense.get()?.id)
            .singleOrNull);
      },
    );
  }

  onMonthBackButtonClick() {
    // advances 1 month backward in the current displayed
    // retrieve the corresponding expenses by the year and month
    currentDate.set(DateUtils.addMonthsToMonthDate(currentDate.get(), -1));
    getExpenses();
  }

  onMonthForwardButtonClick() {
    // advances 1 month in the current displayed
    // retrieve the corresponding expenses by the year and month
    currentDate.set(DateUtils.addMonthsToMonthDate(currentDate.get(), 1));
    getExpenses();
  }

  onExpenseAddButtonClicked() async {
    // navigate to expense forward form page
    await Modular.to.pushNamed(
        RouteConstants.expenseRoute + RouteConstants.formExpenseRoute);
    getExpenses();
  }

  onExpenseDetailsEditButtonClicked() async {
    // navigate to expense forward form page with arguments
    await Modular.to.pushNamed(
      RouteConstants.expenseRoute + RouteConstants.formExpenseRoute,
      arguments: {'expense_id': selectedExpense.get()?.id},
    );
    getExpenses();
  }

  onExpenseDetailsDeleteConfirmationButtonClicked() async {
    try {
      // call to delete expense use case
      // if error,  a message is displayed
      // if success, expense is deleted and removed from state object and list and a message is displayed
      final result =
          await expenseUseCases.deleteExpense(expenseId: selectedExpense.get()!.id!);
      result.fold(
        (error) => MessageService.showErrorMessage('Erro ao excluir despesa'),
        (success) {
          expensesList.removeWhere((element) => element.id == selectedExpense.get()?.id);
          MessageService.showMessage('Despesa excluída!');
          Modular.to.popUntil((route) => route.settings.name == RouteConstants.expenseRoute);
        },
      );
    } on Exception {
      rethrow;
    }
  }

  onExpenseDetailsMarkAsPaidButtonClicked() async {
    try {
      // call to mark as paid expense use case
      final result = await expenseUseCases.markAsPaid(expenseEntity: selectedExpense.get()!);
      // if error,  a message is displayed
      // if success, the paid is toggled, the current selected entity object state and list is updated
      // and a message is displayed
      result.fold(
        (error) => MessageService.showErrorMessage(error.message),
        (success) {
          MessageService.showMessage('Pago!');
          expensesList.replace((e) => e.id == selectedExpense.get()?.id, selectedExpense.get()!);
          selectedExpense.refresh();
        },
      );
    } on Exception {
      rethrow;
    }
  }

  onExpenseDetailsPaymentTypeSelected(PaymentTypeEntity? selected) async {
    try {
      // call to set the selected payment type to selected expense
      final result = await expenseUseCases.setPaymentTypeForExpense(
        expenseEntity: selectedExpense.get()!,
        paymentTypeEntity: selected,
      );

      // if successful, shows an info message
      //otherwise, shows an error message
      result.fold(
        (error) => MessageService.showErrorMessage(error.message),
        (success) {
          MessageService.showMessage('Alterado!');
          expensesList.replace((e) => e.id == selectedExpense.get()?.id, selectedExpense.get()!);
          selectedExpense.refresh();
        },
      );
    } on Exception {
      rethrow;
    }
  }
}
