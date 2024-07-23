import 'package:fpdart/fpdart.dart';
import 'package:myselff_flutter/app/core/exceptions/database_exception.dart';

import '../entity/payment_type_detail_entity.dart';
import '../entity/payment_type_entity.dart';

abstract class PaymentTypeRepository {
  Future<Either<LocalDatabaseException, List<PaymentTypeDetailEntity>>> getPaymentTypesDetailed();
  Future<Either<LocalDatabaseException, void>> insertPaymentType({required PaymentTypeEntity paymentTypeEntity});
  Future<Either<LocalDatabaseException, void>> updatePaymentType({required PaymentTypeEntity paymentTypeEntity});
  Future<Either<LocalDatabaseException, void>> deletePaymentType({required int paymentTypeId});
  Future<Either<LocalDatabaseException, bool>> existsPaymentTypeByName({required String name});
  Future<Either<LocalDatabaseException, List<PaymentTypeEntity>>> getPaymentTypes();
}