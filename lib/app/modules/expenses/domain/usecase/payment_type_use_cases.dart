import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../entity/payment_type_detail_entity.dart';
import '../entity/payment_type_entity.dart';
import '../repository/payment_type_repository.dart';

class PaymentTypeUseCases {

  final PaymentTypeRepository _repository;
  const PaymentTypeUseCases(this._repository);

  Future<Either<DatabaseException, List<PaymentTypeDetailEntity>>> getPaymentTypesDetailed() async {
    // returns a list of all payment types with its expenses count
    return _repository.getPaymentTypesDetailed();
  }

  Future<Either<DatabaseException, void>> savePaymentType({required PaymentTypeEntity paymentTypeEntity}) async {
    // todo validate the payment type properties
    // BR1: payment types must have different name

    // check if the payment type has already been saved (by containing a non-empty id)
    if (paymentTypeEntity.id == null) {
      // if an id doesn't exist, the payment type will be inserted
      return _repository.insertPaymentType(paymentTypeEntity: paymentTypeEntity);
    } else {
      // otherwise, it will be updated
      return _repository.updatePaymentType(paymentTypeEntity: paymentTypeEntity);
    }
  }

  Future<Either<DatabaseException, void>> deletePaymentType({required int paymentTypeId}) async {
    // deletes the payment type by the given id
    return _repository.deletePaymentType(paymentTypeId: paymentTypeId);
  }
}