import 'package:myself_flutter/app/core/commons/model_utils.dart';
import 'package:myself_flutter/app/core/services/reactive_service.dart';
import 'package:myself_flutter/app/modules/expenses/domain/repository/expenses_repository.dart';

import '../../domain/model/expense_model.dart';
import 'expenses_list_states.dart';

class ExpensesListController extends ReactiveService<IExpensesListState> {
  ExpensesListController() : super(ExpensesListStart());
  ExpensesRepository? repository; // todo inject

  DateTime date = DateTime.now().copyWith(day: 1);

  double totalPaid = 0.0;
  double totalExpenses = 0.0;

  List<ExpenseModel> expenses = [
    ExpenseModel(id: ModelUtils.nextId(), value: 20, paid: true, description: 'Despesa', paymentDate: DateTime.utc(2020, 5, 26)),
    ExpenseModel(id: ModelUtils.nextId(), value: 20, paid: false, description: 'Despesa', paymentDate: DateTime.utc(2020, 5, 26)),
    ExpenseModel(id: ModelUtils.nextId(), value: 20, paid: false, description: 'Despesa', paymentDate: DateTime.utc(2020, 5, 26)),
    ExpenseModel(id: ModelUtils.nextId(), value: 20, paid: true, description: 'Despesa', paymentDate: DateTime.utc(2020, 5, 26)),
    ExpenseModel(id: ModelUtils.nextId(), value: 20, paid: true, description: 'Despesa', paymentDate: DateTime.utc(2020, 5, 26)),
  ];

  void init() async {
    _updateState();
  }

  void previousMonth() {
    date = date.subtract(const Duration(days: 1)).copyWith(day: 1);
    _updateState();
  }

  void nextMonth() {
    date = date.add(const Duration(days: 31)).copyWith(day: 1);
    _updateState();
  }

  _updateState() {
    emit(ExpensesListLoading());

    // TODO expenses = repository.findAllByDate(this.date);

    totalExpenses = 0.0;
    totalPaid = 0.0;

    for (var element in expenses) {
      totalExpenses += element.value;
      if (element.paid) totalPaid += element.value;
    }

    emit(ExpensesListSuccess());
  }
}
