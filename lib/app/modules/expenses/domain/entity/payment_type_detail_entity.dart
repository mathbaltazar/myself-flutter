import 'package:myselff_flutter/app/modules/expenses/domain/entity/payment_type_entity.dart';

class PaymentTypeDetailEntity {
  PaymentTypeDetailEntity({
    required this.paymentType,
    required this.currentMonthExpenseCount,
    required this.expenseCount,
  });

  PaymentTypeEntity paymentType;
  int currentMonthExpenseCount;
  int expenseCount;
}
