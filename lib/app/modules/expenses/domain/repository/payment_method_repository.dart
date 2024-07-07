import 'package:myselff_flutter/app/core/data/repository/crud_repository.dart';

import '../model/detailed_payment_method_model.dart';
import '../model/payment_method_model.dart';

abstract class PaymentMethodRepository extends CrudRepository<PaymentMethodModel> {
  Future<bool> existsByName(String name);
  Future<List<DetailedPaymentMethodModel>> findAllDetailed();
}