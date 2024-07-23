import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:myselff_flutter/app/core/constants/route_constants.dart';
import 'package:myselff_flutter/app/core/extensions/list_extensions.dart';
import 'package:myselff_flutter/app/core/services/message_service.dart';

import '../../domain/entity/expense_entity.dart';
import '../../domain/entity/payment_type_entity.dart';
import '../../domain/usecase/expense_use_cases.dart';

part '../pages/expenses_list_controller.g.dart';

class ExpensesListController = _ExpensesListController
    with _$ExpensesListController;

abstract class _ExpensesListController with Store {
  _ExpensesListController(this.expenseUseCases);

  final ExpenseUseCases expenseUseCases;

  @computed
  double get totalExpensesAmount => expenses.fold(
      0, (previousValue, element) => previousValue + element.amount);
  @computed
  double get totalPaidExpensesAmount => expenses
      .where((element) => element.paid)
      .fold(0, (previousValue, element) => previousValue + element.amount);
  @computed
  double get totalUnpaid => totalExpensesAmount - totalPaidExpensesAmount;

  @observable
  DateTime currentDate = DateTime.now();
  @action
  setCurrentDate(DateTime value) => currentDate = value;

  @observable
  ObservableList<ExpenseEntity> expenses = ObservableList();
  @action
  setExpensesList(List<ExpenseEntity> value) {
    expenses = ObservableList.of(value);
    if (selectedExpense != null) {
      selectedExpense = value.where((element) => element.id == selectedExpense?.id).singleOrNull;
    }
  }

  @observable
  ExpenseEntity? selectedExpense;
  @action
  setSelectedExpense(ExpenseEntity? value) => selectedExpense = value;

  getExpenses() async {
    // call to retrieve the expenses by their year and month
    // if error, show a message
    // if success, set the result to the expense state object list
    final result = await expenseUseCases.getExpensesByYearMonth(
      year: currentDate.year,
      month: currentDate.month,
    );

    result.fold(
      (error) {
        MessageService.showErrorMessage(error.message);
        debugPrint('_ExpensesListController.getExpenses${error.message}');
      },
      (items) => setExpensesList(items),
    );
  }

  onMonthBackButtonClick() {
    // advances 1 month backward in the current displayed
    // retrieve the corresponding expenses by the year and month
    setCurrentDate(DateUtils.addMonthsToMonthDate(currentDate, -1));
    getExpenses();
  }

  onMonthForwardButtonClick() {
    // advances 1 month in the current displayed
    // retrieve the corresponding expenses by the year and month
    setCurrentDate(DateUtils.addMonthsToMonthDate(currentDate, 1));
    getExpenses();
  }

  onExpenseAddButtonClicked() async {
    // navigate to expense forward form page
    await Modular.to.pushNamed(
        RouteConstants.expenseRoute + RouteConstants.formExpenseRoute);
    getExpenses();
  }

  onExpenseDetailsEditButtonClicked() async {
    // navigate to expense forward form page
    await Modular.to.pushNamed(
      RouteConstants.expenseRoute + RouteConstants.formExpenseRoute,
      arguments: {'expense_id': selectedExpense?.id},
    );
    getExpenses();
  }

  onExpenseDetailsDeleteConfirmationButtonClicked() async {
    try {
      // call to delete expense use case
      // if error,  a message is displayed
      // if success, expense is deleted and removed from state object and list and a message is displayed
      final result =
          await expenseUseCases.deleteExpense(expenseId: selectedExpense!.id!);
      result.fold(
        (error) => MessageService.showErrorMessage('Erro ao excluir despesa'),
        (success) {
          expenses.removeWhere((element) => element.id == selectedExpense?.id);
          setSelectedExpense(null);
          MessageService.showMessage('Despesa excluída!');
        },
      );
    } on Exception {
      rethrow;
    }
  }

  onExpenseDetailsPaidToggleButtonClicked() async {
    try {
      // call to toggle paid expense use case
      final result = await expenseUseCases.togglePaid(expenseEntity: selectedExpense!);
      // if error,  a message is displayed
      // if success, the paid is toggled, the current selected entity object state and list is updated
      // and a message is displayed
      result.fold(
            (error) => MessageService.showErrorMessage(error.message),
            (success) {
          MessageService.showMessage('Alterado!');
          expenses.replace((e) => e.id == selectedExpense?.id, selectedExpense!);
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
        expenseEntity: selectedExpense!,
        paymentTypeEntity: selected,
      );

      // if successful, shows an info message
      //otherwise, shows an error message
      result.fold(
        (error) => MessageService.showErrorMessage(error.message),
        (success) => MessageService.showMessage('Alterado!'),
      );
    } on Exception {
      rethrow;
    }
  }

  signOut() async {
    // move to isolated scope (SOLID warning!!!!!!)
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }
}
