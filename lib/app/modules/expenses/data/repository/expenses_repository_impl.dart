import 'package:myself_flutter/app/core/data/database_structure.dart';
import 'package:myself_flutter/app/core/data/typeconverters/type_converters.dart';
import 'package:myself_flutter/app/core/utils/formatters/date_formatter.dart';
import 'package:myself_flutter/app/modules/expenses/domain/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/repository/expenses_repository.dart';

class ExpensesRepositoryImpl extends ExpensesRepository {
  @override
  Future<List<ExpenseModel>> findAll() async {
    final db = await getDatabase();
    var maps = await db.query(DatabaseTables.expense);
    List<ExpenseModel> expensesList = List.generate(
      maps.length,
      (index) => ExpenseModel(
          id: maps[index]['id'].toString(),
          paymentDate: maps[index]['paymentDate'].toString().parseFormatted(database: true),
          description: maps[index]['description'].toString(),
          amount: maps[index]['amount'].parseDouble(),
          paid: maps[index]['paid'].parseBoolean()),
    );
    return expensesList;
  }

  @override
  Future<ExpenseModel?> findById(String id) async {
    final db = await getDatabase();
    var query = await db
        .query(DatabaseTables.expense, where: 'id = ?', whereArgs: [id]);
    var expenseMap = query.firstOrNull;
    if (expenseMap != null) {
      return ExpenseModel(
          id: id,
          paymentDate: expenseMap['paymentDate'].toString().parseFormatted(database: true),
          description: expenseMap['description'].toString(),
          amount: expenseMap['amount'].parseDouble(),
          paid: expenseMap['paid'].parseBoolean());
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
  void deleteById(String id) async {
    final db = await getDatabase();
    await db.delete(
      DatabaseTables.expense,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
