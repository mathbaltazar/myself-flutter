import 'package:myselff_flutter/app/core/data/typeconverters/type_converters.dart';
import 'package:myselff_flutter/app/core/utils/formatters/date_formatter.dart';

class ExpenseModel {
  int? id;
  bool paid;
  double amount;
  String description;
  DateTime paymentDate;

  ExpenseModel({
    this.id,
    required this.paymentDate,
    required this.description,
    required this.amount,
    required this.paid,
  });

  Map<String, Object?> toMap() {
    return {
      'id' : id,
      'paid' : paid,
      'amount' : amount,
      'description' : description,
      'paymentDate' : paymentDate.format(database: true),
    };
  }

  static ExpenseModel fromMap(Map<String, Object?> map) {
    return ExpenseModel(
      id: map['id'] as int,
      paymentDate: map['paymentDate'].toString().parseFormatted(database: true),
      description: map['description'].toString(),
      amount: map['amount']!.parseDouble(),
      paid: map['paid'].parseBoolean(),
    );
  }
}
