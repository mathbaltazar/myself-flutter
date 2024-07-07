import 'package:myselff_flutter/app/modules/expenses/domain/model/payment_method_model.dart';

class DetailedPaymentMethodModel {
  DetailedPaymentMethodModel({
    required this.paymentMethod,
    this.currentMonthExpenseCount = 0,
    this.expenseCount = 0,
  });

  PaymentMethodModel paymentMethod;
  int currentMonthExpenseCount;
  int expenseCount;
}
