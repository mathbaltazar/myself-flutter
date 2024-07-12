import 'package:fpdart/fpdart.dart';
import 'package:myselff_flutter/app/modules/expenses/data/datasource/local/_collections/expense_collection.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entity/expense_entity.dart';
import '../../domain/repository/expense_repository.dart';
import '../datasource/local/expense_local_data_source.dart';

class ExpensesRepositoryImpl extends ExpensesRepositoryDeprecated {
  @override
  Future<List<ExpenseEntity>> findAll() async {
    /*final db = await getDatabase();
    List<Map<String, Object?>> queryResult = await db.query(DatabaseTables.expense, orderBy: 'id DESC');
    List<ExpenseEntity> expensesList = List.generate(
      queryResult.length,
      (index) => ExpenseCollection.fromMap(queryResult[index]),
    );*/
    return List.empty();
  }

  @override
  Future<ExpenseEntity?> findById(int id) async {
    /*final db = await getDatabase();
    var queryResult = await db
        .query(DatabaseTables.expense, where: 'id = ?', whereArgs: [id]);
    Map<String, Object?>? map = queryResult.firstOrNull;
    if (map != null) {
      return ExpenseCollection.fromMap(map);
    }*/
    return null;
  }

  @override
  void save(ExpenseEntity expense) async {
    /*final db = await getDatabase();
    final model = ExpenseCollection(
      id: expense.id,
      paid: expense.paid,
      amount: expense.amount,
      description: expense.description,
      paymentDate: expense.paymentDate,
      paymentMethodId: expense.paymentMethodId,
      //paymentMethod: expense.paymentMethod
    );

    await db.insert(DatabaseTables.expense, model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);*/
  }

  @override
  void update(ExpenseEntity expense) async {
    /*final db = await getDatabase();
    final model = ExpenseCollection(
      id: expense.id,
      paid: expense.paid,
      amount: expense.amount,
      description: expense.description,
      paymentDate: expense.paymentDate,
      paymentMethodId: expense.paymentMethodId,
      //paymentMethod: expense.paymentMethod
    );

    await db.update(
      DatabaseTables.expense,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );*/
  }

  @override
  void deleteById(int id) async {
    /*final db = await getDatabase();
    await db.delete(
      DatabaseTables.expense,
      where: 'id = ?',
      whereArgs: [id],
    );*/
  }
}

class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl(this._expenseLocalDataSource);

  final ExpenseLocalDataSource _expenseLocalDataSource;


  @override
  Future<Either<DatabaseException, void>> deleteExpense({required int expenseId}) async {
    try {
      final result = await _expenseLocalDataSource.delete(expenseId: expenseId);
      return Right(result);
    } on DatabaseException catch(e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DatabaseException, List<ExpenseEntity>>> getExpensesByYearMonth({required int year, required int month}) async {
    try {
      final result = await _expenseLocalDataSource.getExpensesByYearMonth(year: year, month: month);
      return Right(result.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DatabaseException, void>> insertExpense({required ExpenseEntity expenseEntity}) async {
    try {
      final result = await _expenseLocalDataSource.insert(
        expenseCollection: const ExpenseCollection({}).fromEntity(expenseEntity),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DatabaseException, void>> updateExpense({required ExpenseEntity expenseEntity}) async {
    try {
      final result = await _expenseLocalDataSource.update(
        expenseCollection: const ExpenseCollection({}).fromEntity(expenseEntity),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(e);
    }
  }

}
