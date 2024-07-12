import 'package:fpdart/fpdart.dart';
import 'package:myselff_flutter/app/core/data/repository/crud_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../entity/payment_type_detail_entity.dart';
import '../entity/payment_type_entity.dart';

abstract class PaymentMethodRepository extends CrudRepository<PaymentTypeEntity> {
  Future<bool> existsByName(String name);
  Future<List<PaymentTypeDetailEntity>> findAllWithCount();
}

abstract class PaymentTypeRepository {
  Future<Either<DatabaseException, List<PaymentTypeDetailEntity>>> getPaymentTypesDetailed();
  Future<Either<DatabaseException, void>> insertPaymentType({required PaymentTypeEntity paymentTypeEntity});
  Future<Either<DatabaseException, void>> updatePaymentType({required PaymentTypeEntity paymentTypeEntity});
  Future<Either<DatabaseException, void>> deletePaymentType({required int paymentTypeId});
  Future<Either<DatabaseException, bool>> existsPaymentTypeByName({required String name});
}