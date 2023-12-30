import 'package:myselff_flutter/app/core/data/database_structure.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/model/payment_method_model.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/repository/payment_method_repository.dart';
import 'package:sqflite/sqflite.dart';

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
  Future<bool> existsByName(String name) async {
    final db = await getDatabase();
    List<Map<String, Object?>> records = await db.query(
        DatabaseTables.paymentMethod,
        where: 'name = ?',
        whereArgs: [name]);
    return records.isNotEmpty && records.length == 1;
  }
}
