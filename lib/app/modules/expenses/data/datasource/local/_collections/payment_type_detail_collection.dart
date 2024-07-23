import 'dart:collection';

import '../../../../domain/entity/payment_type_detail_entity.dart';
import '../../_mappers/entity_mapper.dart';
import 'payment_type_collection.dart';

class PaymentTypeDetailCollection extends MapView<String, dynamic>
    with EntityMapper<PaymentTypeDetailCollection, PaymentTypeDetailEntity> {
  const PaymentTypeDetailCollection(super.map);

  static const paymentType = 'payment_type';
  static const expenseCount = 'expense_count';
  static const currentMonthCount = 'current_month_count';

  @override
  PaymentTypeDetailCollection fromEntity(PaymentTypeDetailEntity entity) {
    throw UnimplementedError();
  }

  @override
  PaymentTypeDetailEntity toEntity() {
    return PaymentTypeDetailEntity(
      paymentType: PaymentTypeCollection(this).toEntity(),
      currentMonthExpenseCount: this[currentMonthCount],
      expenseCount: this[expenseCount],
    );
  }
}
