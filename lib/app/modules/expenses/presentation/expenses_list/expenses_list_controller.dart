import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:myselff_flutter/app/core/routes/app_routes.dart';

import '../../domain/model/expense_model.dart';
import '../../domain/repository/expenses_repository.dart';
import 'model/resume_model.dart';

part 'expenses_list_controller.g.dart';

class ExpensesListController = _ExpensesListController
    with _$ExpensesListController;

abstract class _ExpensesListController with Store {
  _ExpensesListController(this.repository) {
    loadExpenses(resumeModel.currentDate);
  }

  final ExpensesRepository repository;

  @observable
  ResumeModel resumeModel = ResumeModel.instance();

  @action
  setResumeModel(value) => resumeModel = value;

  @observable
  ObservableList<ExpenseModel> expenses = ObservableList();

  void previousMonth() {
    var date = resumeModel.currentDate
        .subtract(const Duration(days: 1))
        .copyWith(day: 1);
    loadExpenses(date);
  }

  void nextMonth() {
    var date =
        resumeModel.currentDate.add(const Duration(days: 31)).copyWith(day: 1);
    loadExpenses(date);
  }

  void editExpense(String id) async {
    dynamic persisted = await Modular.to
        .popAndPushNamed(AppRoutes.saveExpense, arguments: {'expense_id': id});
    if (persisted == true) {
      loadExpenses(resumeModel.currentDate);
    }
  }

  void deleteExpense(String id) async {
    repository.deleteById(id);
    loadExpenses(resumeModel.currentDate);
  }

  void togglePaid(ExpenseModel expense) async {
    expense.paid = !expense.paid;
    repository.save(expense);
    loadExpenses(resumeModel.currentDate);
  }

  void loadExpenses(DateTime currentDate) async {
    List<ExpenseModel> loadedExpenses = await repository.findAll();
    loadedExpenses = loadedExpenses
        .where((expense) =>
            expense.paymentDate.year == currentDate.year &&
            expense.paymentDate.month == currentDate.month)
        .toList();

    double totalExpenses = 0;
    double totalPaid = 0;

    for (var expense in loadedExpenses) {
      totalExpenses += expense.amount;
      if (expense.paid) {
        totalPaid += expense.amount;
      }
    }

    setResumeModel(ResumeModel(
      currentDate: currentDate,
      totalExpenses: totalExpenses,
      totalPaid: totalPaid,
    ));
    expenses.clear();
    expenses.addAll(loadedExpenses);
  }
}
