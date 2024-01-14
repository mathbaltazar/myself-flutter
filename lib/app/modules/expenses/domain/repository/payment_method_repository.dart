import 'package:myselff_flutter/app/core/data/repository/crud_repository.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/model/payment_method_model.dart';

abstract class PaymentMethodRepository extends CrudRepository<PaymentMethodModel> {
  Future<bool> existsByName(String name);
}