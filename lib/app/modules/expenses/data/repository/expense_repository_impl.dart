import 'package:fpdart/fpdart.dart';
import 'package:myselff/app/core/exceptions/database_exception.dart';
import 'package:myselff/app/core/extensions/object_extensions.dart';

import '../../domain/entity/expense_entity.dart';
import '../../domain/repository/expense_repository.dart';
import '../datasource/local/_collections/expense_collection.dart';
import '../datasource/local/expense/expense_local_data_source.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl(this._expenseLocalDataSource);

  final ExpenseLocalDataSource _expenseLocalDataSource;


  @override
  Future<Either<LocalDatabaseException, void>> deleteExpense({required int expenseId}) async {
    try {
      final result = await _expenseLocalDataSource.delete(expenseId: expenseId);
      return Right(result);
    } on LocalDatabaseException catch(e) {
      return Left(e);
    }
  }

  @override
  Future<Either<LocalDatabaseException, List<ExpenseEntity>>> getExpensesByYearMonth({required int year, required int month}) async {
    try {
      final result = await _expenseLocalDataSource.getExpensesByYearMonth(year: year, month: month);
      return Right(result.map((e) => e.toEntity()).toList());
    } on LocalDatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<LocalDatabaseException, void>> insertExpense({required ExpenseEntity expenseEntity}) async {
    try {
      final result = await _expenseLocalDataSource.insert(
        expenseCollection: const ExpenseCollection({}).fromEntity(expenseEntity),
      );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<LocalDatabaseException, void>> updateExpense({required ExpenseEntity expenseEntity}) async {
    try {
      final result = await _expenseLocalDataSource.update(
        expenseCollection: const ExpenseCollection({}).fromEntity(expenseEntity),
      );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<LocalDatabaseException, ExpenseEntity?>> getExpenseById({required int? expenseId}) async {
    try {
      final result = await _expenseLocalDataSource.getById(id: expenseId);
      return Right(result?.let((it) => it.toEntity()));
    } on LocalDatabaseException catch (e) {
      return Left(e);
    }
  }

}
