import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entity/payment_type_detail_entity.dart';
import '../../domain/entity/payment_type_entity.dart';
import '../../domain/repository/payment_type_repository.dart';
import '../datasource/local/_collections/payment_type_collection.dart';
import '../datasource/local/payment_type_local_data_source.dart';

class PaymentMethodRepositoryImpl extends PaymentMethodRepository {
  @override
  Future<List<PaymentTypeEntity>> findAll() async {
    /*final db = await getDatabase();
    List<Map<String, Object?>> records =
        await db.query(DatabaseTables.paymentMethod, orderBy: 'name');
    List<PaymentTypeEntity> paymentMethods = List.generate(
      records.length,
      (index) => PaymentTypeEntity.fromMap(records[index]),
    );
    return paymentMethods;*/
    return List.empty();
  }

  @override
  Future<PaymentTypeEntity?> findById(int id) async {
    /*final db = await getDatabase();
    var records = await db
        .query(DatabaseTables.paymentMethod, where: 'id = ?', whereArgs: [id]);
    Map<String, Object?>? map = records.firstOrNull;
    if (map != null) {
      return PaymentTypeEntity.fromMap(map);
    }*/
    return null;
  }

  @override
  void save(PaymentTypeEntity model) async {
    /*final db = await getDatabase();
    await db.insert(
      DatabaseTables.paymentMethod,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );*/
  }

  @override
  void update(PaymentTypeEntity model) async {
   /* final db = await getDatabase();
    await db.update(
      DatabaseTables.paymentMethod,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );*/
  }

  @override
  void deleteById(int id) async {
    /*final db = await getDatabase();
    await db.delete(
      DatabaseTables.paymentMethod,
      where: 'id = ?',
      whereArgs: [id],
    );*/
  }

  @override
  Future<List<PaymentTypeDetailEntity>> findAllWithCount() async {
    /*final db = await getDatabase();
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
      return PaymentTypeDetailEntity(
        paymentType: PaymentTypeEntity.fromMap(e),
        currentMonthExpenseCount: e['currentMonthCount'] as int? ?? 0,
        expenseCount: e['expenseCount'] as int? ?? 0,
      );
    }).toList();*/
    return List.empty();
  }

  @override
  Future<bool> existsByName(String name) async {
    /*final db = await getDatabase();

    final result = await db.query(
      DatabaseTables.paymentMethod,
      where: 'name like ?',
      whereArgs: [name],
    );
    return result.firstOrNull != null;*/
    return false;
  }
}

class PaymentTypeRepositoryImpl implements PaymentTypeRepository {
  PaymentTypeRepositoryImpl(this._paymentTypeLocalDataSource);

  final PaymentTypeLocalDataSource _paymentTypeLocalDataSource;
  @override
  Future<Either<DatabaseException, void>> deletePaymentType({required int paymentTypeId}) async {
    try {
      final result = await _paymentTypeLocalDataSource.delete(paymentTypeId: paymentTypeId);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DatabaseException, bool>> existsPaymentTypeByName({required String name}) async {
    try {
      final result = await _paymentTypeLocalDataSource.existsByName(name: name);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DatabaseException, List<PaymentTypeDetailEntity>>> getPaymentTypesDetailed() async {
    try {
      final result = await _paymentTypeLocalDataSource.getPaymentTypeWithDetailsList();
      return Right(result.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DatabaseException, void>> insertPaymentType({required PaymentTypeEntity paymentTypeEntity}) async {
    try {
      final result = await _paymentTypeLocalDataSource.insert(
        paymentTypeCollection:
            const PaymentTypeCollection({}).fromEntity(paymentTypeEntity),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DatabaseException, void>> updatePaymentType({required PaymentTypeEntity paymentTypeEntity}) async {
    try {
      final result = await _paymentTypeLocalDataSource.update(
        paymentTypeCollection:
            const PaymentTypeCollection({}).fromEntity(paymentTypeEntity),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(e);
    }
  }

}
