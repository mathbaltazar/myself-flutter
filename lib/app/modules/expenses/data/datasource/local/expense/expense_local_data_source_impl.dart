import 'package:intl/intl.dart';
import 'package:myselff_flutter/app/core/database/local_database.dart';
import 'package:myselff_flutter/app/core/exceptions/database_exception.dart';
import 'package:sqflite/sqflite.dart';

import '../_collections/expense_collection.dart';
import 'expense_local_data_source.dart';

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  ExpenseLocalDataSourceImpl(this.localDatabase);

  final LocalDatabase localDatabase;

  @override
  Future<List<ExpenseCollection>> getExpensesByYearMonth(
      {required int year, required int month}) async {
    try {
      final yearMonthQueryParam =
          DateFormat('yyyy-MM').format(DateTime(year, month));

      const query = '''
          SELECT * FROM expense e
              LEFT JOIN payment_type p 
                  ON e.fk_expense_payment_type_id = p.payment_type_id 
          WHERE e.expense_payment_date LIKE ?
      ''';

      final result =
          await localDatabase.db.rawQuery(query, ['$yearMonthQueryParam%']);
      return result.map(ExpenseCollection.new).toList();
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }

  @override
  Future<void> insert({required ExpenseCollection expenseCollection}) async {
    try {
      await localDatabase.db.transaction((txn) async {
        return await txn.insert('expense', expenseCollection);
      });
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }

  @override
  Future<void> delete({required int expenseId}) async {
    try {
      await localDatabase.db.transaction((txn) async {
        return await txn.delete(
          'expense',
          where: '${ExpenseCollection.id} = ?',
          whereArgs: [expenseId],
        );
      });
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }

  @override
  Future<void> update({required ExpenseCollection expenseCollection}) async {
    try {
      await localDatabase.db.transaction((txn) async {
        await txn.update(
          'expense',
          expenseCollection,
          where: '${ExpenseCollection.id} = ?',
          whereArgs: [expenseCollection[ExpenseCollection.id]],
        );
      });
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }

  @override
  Future<ExpenseCollection?> getById({required int? id}) async {
    try {
      const query = '''
          SELECT * FROM expense e
              LEFT JOIN payment_type p 
                  ON e.fk_expense_payment_type_id = p.payment_type_id
          WHERE e.expense_id = ?
      ''';

      final result = await localDatabase.db.rawQuery(query, [id]);
      return result.map(ExpenseCollection.new).singleOrNull;
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }
}
