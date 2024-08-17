import 'package:fpdart/fpdart.dart';
import 'package:myselff/app/core/exceptions/database_exception.dart';

import '../../domain/entity/payment_type_detail_entity.dart';
import '../../domain/entity/payment_type_entity.dart';
import '../../domain/repository/payment_type_repository.dart';
import '../datasource/local/_collections/payment_type_collection.dart';
import '../datasource/local/payment_type/payment_type_local_data_source.dart';

class PaymentTypeRepositoryImpl implements PaymentTypeRepository {
  PaymentTypeRepositoryImpl(this._paymentTypeLocalDataSource);

  final PaymentTypeLocalDataSource _paymentTypeLocalDataSource;
  @override
  Future<Either<LocalDatabaseException, void>> deletePaymentType({required int paymentTypeId}) async {
    try {
      final result = await _paymentTypeLocalDataSource.delete(paymentTypeId: paymentTypeId);
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<LocalDatabaseException, bool>> existsPaymentTypeByName({required String name}) async {
    try {
      final result = await _paymentTypeLocalDataSource.existsByName(name: name);
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<LocalDatabaseException, List<PaymentTypeDetailEntity>>> getPaymentTypesDetailed() async {
    try {
      final result = await _paymentTypeLocalDataSource.getPaymentTypeWithDetailsList();
      return Right(result.map((e) => e.toEntity()).toList());
    } on LocalDatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<LocalDatabaseException, void>> insertPaymentType({required PaymentTypeEntity paymentTypeEntity}) async {
    try {
      final result = await _paymentTypeLocalDataSource.insert(
        paymentTypeCollection:
            const PaymentTypeCollection({}).fromEntity(paymentTypeEntity),
      );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<LocalDatabaseException, void>> updatePaymentType({required PaymentTypeEntity paymentTypeEntity}) async {
    try {
      final result = await _paymentTypeLocalDataSource.update(
        paymentTypeCollection:
            const PaymentTypeCollection({}).fromEntity(paymentTypeEntity),
      );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<LocalDatabaseException, List<PaymentTypeEntity>>> getPaymentTypes() async {
    try {
      final result = await _paymentTypeLocalDataSource.getAllPaymentTypes();
      return Right(result.map((e) => e.toEntity()).toList());
    } on LocalDatabaseException catch (e) {
      return Left(e);
    }
  }
}
