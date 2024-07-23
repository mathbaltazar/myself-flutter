import 'package:intl/intl.dart';
import 'package:myselff_flutter/app/core/database/local_database.dart';
import 'package:myselff_flutter/app/core/exceptions/database_exception.dart';
import 'package:sqflite/sqflite.dart';

import '../_collections/payment_type_collection.dart';
import '../_collections/payment_type_detail_collection.dart';
import 'payment_type_local_data_source.dart';

class PaymentTypeLocalDataSourceImpl implements PaymentTypeLocalDataSource {
  PaymentTypeLocalDataSourceImpl(this.localDatabase);

  final LocalDatabase localDatabase;

  @override
  Future<void> delete({required int paymentTypeId}) async {
    try {
      await localDatabase.db.transaction((txn) async {
        return await txn.delete(
          'payment_type',
          where: '${PaymentTypeCollection.id} = ?',
          whereArgs: [paymentTypeId],
        );
      });
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }

  @override
  Future<bool> existsByName({required String name}) async {
    try {
      final result = await localDatabase.db.query(
        'payment_type',
        where: '${PaymentTypeCollection.name} like ?',
        whereArgs: [name],
      );
      return result.isNotEmpty;
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }

  @override
  Future<List<PaymentTypeDetailCollection>> getPaymentTypeWithDetailsList() async {
    try {
      String nowYearMonth = DateFormat('yyyy-MM').format(DateTime.now());
      const query = '''
        SELECT p.*,
         COUNT(e.expense_id) AS ${PaymentTypeDetailCollection.expenseCount}, 
         COUNT(e.expense_id) FILTER (WHERE e.expense_payment_date LIKE ?) AS ${PaymentTypeDetailCollection.currentMonthCount}
         FROM payment_type p
            LEFT JOIN expense e ON e.fk_expense_payment_type_id = p.payment_type_id
         GROUP BY p.payment_type_id
      ''';

      final result = await localDatabase.db.rawQuery(query, ['$nowYearMonth%']);
      return result.map(PaymentTypeDetailCollection.new).toList();
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }

  @override
  Future<void> insert({required PaymentTypeCollection paymentTypeCollection}) async {
    try {
      await localDatabase.db.transaction((txn) async =>
          await txn.insert('payment_type', paymentTypeCollection));
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }

  @override
  Future<void> update({required PaymentTypeCollection paymentTypeCollection}) async {
    try {
      await localDatabase.db.transaction((txn) async => await txn.update(
          'payment_type', paymentTypeCollection,
          where: '${PaymentTypeCollection.id} = ?',
          whereArgs: [paymentTypeCollection[PaymentTypeCollection.id]]));
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }

  @override
  Future<List<PaymentTypeCollection>> getAllPaymentTypes() async {
    try {
      final result = await localDatabase.db.query(PaymentTypeCollection.collectionName);
      return result.map(PaymentTypeCollection.new).toList();
    } on DatabaseException catch (e) {
      throw LocalDatabaseException.fromSQLiteDatabaseException(e);
    }
  }
}
