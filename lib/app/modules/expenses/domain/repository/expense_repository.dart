import 'package:fpdart/fpdart.dart';
import 'package:myselff_flutter/app/core/data/repository/crud_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../entity/expense_entity.dart';

abstract class ExpensesRepositoryDeprecated
    extends CrudRepository<ExpenseEntity> {}

abstract class ExpenseRepository {
  //* LOCAL DATA SOURCE
  Future<Either<DatabaseException, List<ExpenseEntity>>> getExpensesByYearMonth({required int year, required int month});
  Future<Either<DatabaseException, void>> insertExpense({required ExpenseEntity expenseEntity});
  Future<Either<DatabaseException, void>> updateExpense({required ExpenseEntity expenseEntity});
  Future<Either<DatabaseException, void>> deleteExpense({required int expenseId});
}
