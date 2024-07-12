import 'package:intl/intl.dart';
import 'package:myselff_flutter/app/core/data/database_structure.dart';
import 'package:sqflite/sqflite.dart';

import '_collections/expense_collection.dart';
import 'expense_local_data_source.dart';

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  ExpenseLocalDataSourceImpl(this.localDatabase);

  final Database localDatabase;

  @override
  Future<List<ExpenseCollection>> getExpensesByYearMonth({required int year, required int month}) async {
    try {
      final yearMonthQueryParam = DateFormat('yyyy-MM').format(DateTime(year, month));

      const query = '''
          SELECT * FROM ${DatabaseTables.expense} e
              LEFT JOIN ${DatabaseTables.paymentType} pt 
                  ON e.payment_type_id = pt.id AND e.payment_date LIKE ?
      ''';
      
      final result = await localDatabase.rawQuery(query, ['$yearMonthQueryParam%']);
      return result.map(ExpenseCollection.new).toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> insert({required ExpenseCollection expenseCollection}) async {
    try {
      await localDatabase.insert(DatabaseTables.expense, expenseCollection);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> delete({required int expenseId}) async {
    try {
      await localDatabase.delete(
          DatabaseTables.expense,
          where: '${ExpenseCollection.id} = ?',
          whereArgs: [expenseId],
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> update({required ExpenseCollection expenseCollection}) async {
    try {
      await localDatabase.update(
        DatabaseTables.expense,
        expenseCollection,
        where: '${ExpenseCollection.id} = ?',
        whereArgs: [expenseCollection[ExpenseCollection.id]],
      );
    } catch (_) {
      rethrow;
    }
  }
}