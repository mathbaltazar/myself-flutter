class PaymentMethodModel {
  int? id;
  String name;

  PaymentMethodModel({
    this.id,
    required this.name,
  });

  factory PaymentMethodModel.none() => PaymentMethodModel(name: 'Nenhum');

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static PaymentMethodModel fromMap(Map<String, Object?> map) {
    return PaymentMethodModel(
      id: map['id'] as int,
      name: map['name'].toString(),
    );
  }
}