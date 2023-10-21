import 'package:myself_flutter/app/core/utils/formatters/date_formatter.dart';

class ExpenseModel {
  String id;
  bool paid;
  double amount;
  String description;
  DateTime paymentDate;

  ExpenseModel({
    required this.id,
    required this.paymentDate,
    required this.description,
    required this.amount,
    required this.paid,
  });

  Map<String, Object> toMap() {
    return {
      'id' : id,
      'paid' : paid,
      'amount' : amount,
      'description' : description,
      'paymentDate' : paymentDate.format(database: true)
    };
  }
}
