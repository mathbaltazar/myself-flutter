import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:myselff_flutter/app/core/routes/app_routes.dart';
import 'package:myselff_flutter/app/core/structure/inline_functions.dart';
import '../../domain/model/payment_method_model.dart';
import '../../domain/repository/payment_method_repository.dart';
import '../../domain/model/expense_model.dart';
import '../../domain/repository/expenses_repository.dart';
import 'model/resume_model.dart';

part 'expenses_list_controller.g.dart';

class ExpensesListController = _ExpensesListController
    with _$ExpensesListController;

abstract class _ExpensesListController with Store {

  _ExpensesListController(this.expenseRepository,
      this.paymentMethodRepository) {
    loadExpenses(resumeModel.currentDate);
  }

  final PaymentMethodRepository paymentMethodRepository;
  final ExpensesRepository expenseRepository;

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

  void editExpense(int id) async {
    dynamic persisted = await Modular.to
        .popAndPushNamed(AppRoutes.expenseRoute + AppRoutes.saveExpense,
        arguments: {'expense_id': id});
    if (persisted == true) {
      loadExpenses(resumeModel.currentDate);
    }
  }

  void deleteExpense(int id) async {
    expenseRepository.deleteById(id);
    loadExpenses(resumeModel.currentDate);
  }

  void togglePaid(ExpenseModel expense) async {
    expense.paid = !expense.paid;
    if (!expense.paid) {
      expense.paymentMethodId = null;
    }
    expenseRepository.save(expense);
    loadExpenses(resumeModel.currentDate);
  }

  void loadExpenses(DateTime currentDate) async {
    List<ExpenseModel> loadedExpenses = await expenseRepository.findAll();
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
      totalUnpaid: totalExpenses - totalPaid,
    ));
    expenses.clear();
    expenses.addAll(loadedExpenses);
  }

  signOut() async {
    // move to isolated scope (SOLID warning!!!!!!)
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }

  Future<List<PaymentMethodModel>> findAllPaymentMethods() =>
      paymentMethodRepository.findAll();

  Future<PaymentMethodModel?> findPaymentMethodById(int? id) async =>
      id?.let((it) => paymentMethodRepository.findById(it));

  @action
  void definePaymentFor(PaymentMethodModel selected,
      ExpenseModel expense) {
    expense.paymentMethodId = selected.id;
    expenseRepository.update(expense);
    loadExpenses(resumeModel.currentDate);
  }
}
