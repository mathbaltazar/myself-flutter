class PaymentTypeEntity {
  PaymentTypeEntity({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory PaymentTypeEntity.none() => PaymentTypeEntity(name: 'Nenhum');

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static PaymentTypeEntity fromMap(Map<String, Object?> map) {
    return PaymentTypeEntity(
      id: map['id'] as int,
      name: map['name'].toString(),
    );
  }
}
