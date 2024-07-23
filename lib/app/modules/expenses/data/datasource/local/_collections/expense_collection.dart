import 'dart:collection';

import 'package:myselff_flutter/app/core/extensions/bool_extensions.dart';
import 'package:myselff_flutter/app/core/extensions/string_extensions.dart';
import 'package:myselff_flutter/app/core/utils/type_converters.dart';

import '../../../../domain/entity/expense_entity.dart';
import '../../_mappers/entity_mapper.dart';
import 'payment_type_collection.dart';

class ExpenseCollection extends MapView<String, dynamic>
    with EntityMapper<ExpenseCollection, ExpenseEntity> {

  static const collectionName = 'expense';

  static final id = 'id'.prefix(collectionName);
  static final paymentDate = 'payment_date'.prefix(collectionName);
  static final description = 'description'.prefix(collectionName);
  static final amount = 'amount'.prefix(collectionName);
  static final paid = 'paid'.prefix(collectionName);
  static final paymentTypeId = 'payment_type_id'.prefix(collectionName).prefix('fk');

  const ExpenseCollection(super.map);

  @override
  ExpenseCollection fromEntity(ExpenseEntity entity) {
    return ExpenseCollection({
      id: entity.id,
      paymentDate: entity.paymentDate.toDateString(),
      description: entity.description,
      amount: entity.amount,
      paid: entity.paid.toBinaryString(),
      paymentTypeId: entity.paymentType?.id,
    });
  }

  @override
  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: this[id],
      paymentDate: this[paymentDate].toString().parseDate(),
      description: this[description].toString(),
      amount: this[amount].toString().parseDouble(),
      paid: this[paid].toString().parseBool(),
      paymentType: this[paymentTypeId] != null ? PaymentTypeCollection(this).toEntity() : null,
    );
  }
}
