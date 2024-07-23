import 'dart:collection';

import 'package:myselff_flutter/app/core/extensions/string_extensions.dart';

import '../../../../domain/entity/payment_type_entity.dart';
import '../../_mappers/entity_mapper.dart';

class PaymentTypeCollection extends MapView<String, dynamic>
    with EntityMapper<PaymentTypeCollection, PaymentTypeEntity> {

  static const collectionName = 'payment_type';

  static final id = 'id'.prefix(collectionName);
  static final name = 'name'.prefix(collectionName);

  const PaymentTypeCollection(super.map);

  @override
  PaymentTypeCollection fromEntity(PaymentTypeEntity entity) {
    return PaymentTypeCollection({
      id: entity.id,
      name: entity.name,
    });
  }

  @override
  PaymentTypeEntity toEntity() {
    return PaymentTypeEntity(
      id: this[id],
      name: this[name],
    );
  }
}
