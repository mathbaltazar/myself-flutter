import 'dart:collection';

import 'package:myselff_flutter/app/core/data/utils/type_converters.dart';

import '../../../../domain/entity/expense_entity.dart';
import '../../_mappers/entity_mapper.dart';
import 'payment_type_collection.dart';

class ExpenseCollection extends MapView<String, dynamic>
    with EntityMapper<ExpenseCollection, ExpenseEntity> {

  static const id = 'id';
  static const paymentDate = 'payment_date';
  static const description = 'description';
  static const amount = 'amount';
  static const paid = 'paid';
  static const paymentTypeId = 'payment_type_id';

  const ExpenseCollection(super.map);

  @override
  ExpenseCollection fromEntity(ExpenseEntity entity) {
    return ExpenseCollection({
      id: entity.id,
      paymentDate: entity.paymentDate.toDateString(),
      description: entity.description,
      amount: entity.amount,
      paid: entity.paid,
      paymentTypeId: entity.paymentType?.id,
    });
  }

  @override
  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: this[id],
      paymentDate: this[paymentDate].toString().parseDate(),
      description: this[description].toString(),
      amount: this[amount].parseDouble(),
      paid: this[paid].parseBoolean(),
      paymentMethodId: this[paymentTypeId] as int?,
      paymentType: PaymentTypeCollection(this).toEntity(),
    );
  }
}
