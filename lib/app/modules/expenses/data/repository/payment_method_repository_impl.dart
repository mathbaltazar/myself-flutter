import 'package:intl/intl.dart';
import 'package:myselff_flutter/app/core/data/database_structure.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/model/detailed_payment_method_model.dart';
import '../../domain/model/payment_method_model.dart';
import '../../domain/repository/payment_method_repository.dart';

class PaymentMethodRepositoryImpl extends PaymentMethodRepository {
  @override
  Future<List<PaymentMethodModel>> findAll() async {
    final db = await getDatabase();
    List<Map<String, Object?>> records =
        await db.query(DatabaseTables.paymentMethod, orderBy: 'name');
    List<PaymentMethodModel> paymentMethods = List.generate(
      records.length,
      (index) => PaymentMethodModel.fromMap(records[index]),
    );
    return paymentMethods;
  }

  @override
  Future<PaymentMethodModel?> findById(int id) async {
    final db = await getDatabase();
    var records = await db
        .query(DatabaseTables.paymentMethod, where: 'id = ?', whereArgs: [id]);
    Map<String, Object?>? map = records.firstOrNull;
    if (map != null) {
      return PaymentMethodModel.fromMap(map);
    }
    return null;
  }

  @override
  void save(PaymentMethodModel model) async {
    final db = await getDatabase();
    await db.insert(
      DatabaseTables.paymentMethod,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  void update(PaymentMethodModel model) async {
    final db = await getDatabase();
    await db.update(
      DatabaseTables.paymentMethod,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  @override
  void deleteById(int id) async {
    final db = await getDatabase();
    await db.delete(
      DatabaseTables.paymentMethod,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<DetailedPaymentMethodModel>> findAllDetailed() async {
    final db = await getDatabase();
    String nowYearMonth = DateFormat('yyyy-MM').format(DateTime.now());
    final query = '''
        SELECT p.*,
         COUNT(e.id) AS expenseCount, 
         COUNT(e.id) FILTER (WHERE e.payment_date LIKE '$nowYearMonth%') AS currentMonthCount
         FROM ${DatabaseTables.paymentMethod} p
            LEFT JOIN ${DatabaseTables.expense} e ON e.payment_method_id = p.id
      GROUP BY p.id
    ''';

    List<Map<String, Object?>> records = await db.rawQuery(query);

    return records.map((e) {
      return DetailedPaymentMethodModel(
        paymentMethod: PaymentMethodModel.fromMap(e),
        currentMonthExpenseCount: e['currentMonthCount'] as int? ?? 0,
        expenseCount: e['expenseCount'] as int? ?? 0,
      );
    }).toList();
  }

  @override
  Future<bool> existsByName(String name) async {
    final db = await getDatabase();

    final result = await db.query(
      DatabaseTables.paymentMethod,
      where: 'name like ?',
      whereArgs: [name],
    );
    return result.firstOrNull != null;
  }
}
