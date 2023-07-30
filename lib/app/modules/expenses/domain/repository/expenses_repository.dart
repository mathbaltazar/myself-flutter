import '../model/expense_model.dart';

abstract class ExpensesRepository {
  List<ExpenseModel> findAll();

  void save(ExpenseModel expense);
}
