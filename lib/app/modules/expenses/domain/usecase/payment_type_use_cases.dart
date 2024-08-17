import 'package:fpdart/fpdart.dart';
import 'package:myselff/app/core/exceptions/database_exception.dart';

import '../entity/payment_type_detail_entity.dart';
import '../entity/payment_type_entity.dart';
import '../repository/payment_type_repository.dart';

class PaymentTypeUseCases {

  final PaymentTypeRepository _repository;
  const PaymentTypeUseCases(this._repository);

  Future<Either<LocalDatabaseException, List<PaymentTypeDetailEntity>>> getPaymentTypesDetailed() async {
    // returns a list of all payment types with its expenses count
    return _repository.getPaymentTypesDetailed();
  }

  Future<Either<LocalDatabaseException, void>> savePaymentType({required PaymentTypeEntity paymentTypeEntity}) async {
    if (paymentTypeEntity.name.isEmpty) {
      // BR0: payment type name must not be empty
      return Left(LocalDatabaseException('O tipo de pagamento deve ser preenchido'));
    }

    // BR1: payment types must have different name
    final existsResult = await _repository.existsPaymentTypeByName(name: paymentTypeEntity.name);
    if (existsResult.isLeft()) return existsResult;
    bool exists = existsResult.getRight().getOrElse(() => false);
    if (exists) {
      return Left(LocalDatabaseException('O tipo de pagamento já existe'));
    }

    // check if the payment type has already been saved (by containing a non-empty id)
    if (paymentTypeEntity.id == null) {
      // if an id doesn't exist, the payment type will be inserted
      return _repository.insertPaymentType(paymentTypeEntity: paymentTypeEntity);
    } else {
      // otherwise, it will be updated
      return _repository.updatePaymentType(paymentTypeEntity: paymentTypeEntity);
    }
  }

  Future<Either<LocalDatabaseException, void>> deletePaymentType({required int paymentTypeId}) async {
    // deletes the payment type by the given id
    return _repository.deletePaymentType(paymentTypeId: paymentTypeId);
  }

  Future<Either<LocalDatabaseException, List<PaymentTypeEntity>>> getPaymentTypes() async {
    // returns a list of all payment type entities
    return _repository.getPaymentTypes();
  }
}