import 'package:myselff_flutter/app/core/data/typeconverters/type_converters.dart';
import 'package:myselff_flutter/app/core/utils/formatters/date_formatter.dart';

class ExpenseModel {
  int? id;
  bool paid;
  double amount;
  String description;
  DateTime paymentDate;
  int? paymentMethodId;

  ExpenseModel({
    this.id,
    required this.paymentDate,
    required this.description,
    required this.amount,
    required this.paid,
    this.paymentMethodId,
  });

  Map<String, Object?> toMap() {
    return {
      'id' : id,
      'paid' : paid,
      'amount' : amount,
      'description' : description,
      'payment_date' : paymentDate.format(database: true),
      'payment_method_id' : paymentMethodId,
    };
  }

  static ExpenseModel fromMap(Map<String, Object?> map) {
    return ExpenseModel(
      id: map['id'] as int,
      paymentDate: map['payment_date'].toString().parseFormatted(database: true),
      description: map['description'].toString(),
      amount: map['amount']!.parseDouble(),
      paid: map['paid'].parseBoolean(),
      paymentMethodId: map['payment_method_id'] as int?,
    );
  }
}
