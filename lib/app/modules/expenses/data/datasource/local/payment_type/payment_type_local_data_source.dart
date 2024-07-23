import 'package:myselff_flutter/app/modules/expenses/data/datasource/local/_collections/payment_type_collection.dart';

import '../_collections/payment_type_detail_collection.dart';

abstract class PaymentTypeLocalDataSource {
  Future<List<PaymentTypeDetailCollection>> getPaymentTypeWithDetailsList();
  Future<void> insert({required PaymentTypeCollection paymentTypeCollection});
  Future<void> update({required PaymentTypeCollection paymentTypeCollection});
  Future<void> delete({required int paymentTypeId});
  Future<bool> existsByName({required String name});
  Future<List<PaymentTypeCollection>> getAllPaymentTypes();
}