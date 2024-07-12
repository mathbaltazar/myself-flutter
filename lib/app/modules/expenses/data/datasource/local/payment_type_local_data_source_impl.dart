import 'package:intl/intl.dart';
import 'package:myselff_flutter/app/core/data/database_structure.dart';
import 'package:sqflite/sqflite.dart';

import '_collections/payment_type_collection.dart';
import '_collections/payment_type_detail_collection.dart';
import 'payment_type_local_data_source.dart';

class PaymentTypeLocalDataSourceImpl implements PaymentTypeLocalDataSource {
  PaymentTypeLocalDataSourceImpl(this.localDatabase);

  final Database localDatabase;

  @override
  Future<void> delete({required int paymentTypeId}) async {
    try {
      await localDatabase.delete(
        DatabaseTables.paymentType,
        where: '${PaymentTypeCollection.id} = ?',
        whereArgs: [paymentTypeId],
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> existsByName({required String name}) async {
    try {
      final result = await localDatabase.query(
        DatabaseTables.paymentType,
        where: '${PaymentTypeCollection.name} like ?',
        whereArgs: [name],
      );
      return result.isNotEmpty;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<PaymentTypeDetailCollection>> getPaymentTypeWithDetailsList() async {
    try {
      String nowYearMonth = DateFormat('yyyy-MM').format(DateTime.now());
      const query = '''
        SELECT pt.*,
         COUNT(e.id) AS ${PaymentTypeDetailCollection.expenseCount}, 
         COUNT(e.id) FILTER (WHERE e.payment_date LIKE ?) AS ${PaymentTypeDetailCollection.currentMonthCount}
         FROM ${DatabaseTables.paymentType} pt
            LEFT JOIN ${DatabaseTables.expense} e ON e.payment_type_id = pt.id
         GROUP BY pt.id
      ''';

      final result = await localDatabase.rawQuery(query, ['$nowYearMonth%']);
      return result.map(PaymentTypeDetailCollection.new).toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> insert(
      {required PaymentTypeCollection paymentTypeCollection}) async {
    try {
      await localDatabase.insert(
          DatabaseTables.paymentType, paymentTypeCollection);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> update(
      {required PaymentTypeCollection paymentTypeCollection}) async {
    try {
      await localDatabase.update(
          DatabaseTables.paymentType, paymentTypeCollection,
          where: '${PaymentTypeCollection.id} = ?',
          whereArgs: [paymentTypeCollection[PaymentTypeCollection.id]]);
    } catch (_) {
      rethrow;
    }
  }
}
