import 'package:myselff/app/modules/expenses/domain/entity/payment_type_entity.dart';

class ExpenseEntity {
  ExpenseEntity({
    this.id,
    required this.paymentDate,
    required this.description,
    required this.amount,
    required this.paid,
    this.paymentType,
  });

  int? id;
  bool paid;
  double amount;
  String description;
  DateTime paymentDate;
  PaymentTypeEntity? paymentType;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          paid == other.paid &&
          amount == other.amount &&
          description == other.description &&
          paymentDate == other.paymentDate &&
          paymentType == other.paymentType;

  @override
  int get hashCode =>
      id.hashCode ^
      paid.hashCode ^
      amount.hashCode ^
      description.hashCode ^
      paymentDate.hashCode ^
      paymentType.hashCode;
}
