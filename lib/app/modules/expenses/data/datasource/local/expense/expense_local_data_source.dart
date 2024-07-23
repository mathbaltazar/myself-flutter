import '../_collections/expense_collection.dart';

abstract class ExpenseLocalDataSource {
  Future<List<ExpenseCollection>> getExpensesByYearMonth({required int year, required int month});
  Future<void> insert({required ExpenseCollection expenseCollection});
  Future<void> update({required ExpenseCollection expenseCollection});
  Future<void> delete({required int expenseId});
  Future<ExpenseCollection?> getById({required int? id});
}
