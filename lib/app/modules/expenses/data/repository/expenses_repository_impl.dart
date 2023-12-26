import 'package:myselff_flutter/app/core/data/database_structure.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/repository/expenses_repository.dart';

class ExpensesRepositoryImpl extends ExpensesRepository {
  @override
  Future<List<ExpenseModel>> findAll() async {
    final db = await getDatabase();
    List<Map<String, Object?>> queryResult = await db.query(DatabaseTables.expense, orderBy: 'id DESC');
    List<ExpenseModel> expensesList = List.generate(
      queryResult.length,
      (index) => ExpenseModel.fromMap(queryResult[index]),
    );
    return expensesList;
  }

  @override
  Future<ExpenseModel?> findById(int id) async {
    final db = await getDatabase();
    var queryResult = await db
        .query(DatabaseTables.expense, where: 'id = ?', whereArgs: [id]);
    Map<String, Object?>? map = queryResult.firstOrNull;
    if (map != null) {
      return ExpenseModel.fromMap(map);
    }
    return null;
  }

  @override
  void save(ExpenseModel expense) async {
    final db = await getDatabase();
    await db.insert(
      DatabaseTables.expense,
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  void update(ExpenseModel expense) async {
    final db = await getDatabase();
    await db.update(
      DatabaseTables.expense,
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  @override
  void deleteById(int id) async {
    final db = await getDatabase();
    await db.delete(
      DatabaseTables.expense,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
