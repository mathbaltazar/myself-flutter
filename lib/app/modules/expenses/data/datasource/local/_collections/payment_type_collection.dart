import 'dart:collection';

import '../../../../domain/entity/payment_type_entity.dart';
import '../../_mappers/entity_mapper.dart';

class PaymentTypeCollection extends MapView<String, dynamic>
    with EntityMapper<PaymentTypeCollection, PaymentTypeEntity> {

  static const id = 'id';
  static const name = 'name';

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
