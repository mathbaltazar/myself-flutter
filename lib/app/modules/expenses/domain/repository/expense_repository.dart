import 'package:fpdart/fpdart.dart';
import 'package:myselff_flutter/app/core/exceptions/database_exception.dart';

import '../entity/expense_entity.dart';

abstract class ExpenseRepository {
  //* LOCAL DATA SOURCE
  Future<Either<LocalDatabaseException, List<ExpenseEntity>>> getExpensesByYearMonth({required int year, required int month});
  Future<Either<LocalDatabaseException, void>> insertExpense({required ExpenseEntity expenseEntity});
  Future<Either<LocalDatabaseException, void>> updateExpense({required ExpenseEntity expenseEntity});
  Future<Either<LocalDatabaseException, void>> deleteExpense({required int expenseId});
}
