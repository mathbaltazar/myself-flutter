class PaymentTypeEntity {
  PaymentTypeEntity({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory PaymentTypeEntity.none() => PaymentTypeEntity(name: 'Nenhum');

  factory PaymentTypeEntity.withName(String name) => PaymentTypeEntity(name: name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentTypeEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
