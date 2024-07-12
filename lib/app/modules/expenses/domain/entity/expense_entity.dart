import 'package:myselff_flutter/app/modules/expenses/domain/entity/payment_type_entity.dart';

class ExpenseEntity {
  ExpenseEntity({
    this.id,
    required this.paymentDate,
    required this.description,
    required this.amount,
    required this.paid,
    this.paymentMethodId,
    this.paymentType,
  });

  int? id;
  bool paid;
  double amount;
  String description;
  DateTime paymentDate;
  int? paymentMethodId;
  PaymentTypeEntity? paymentType;
}
