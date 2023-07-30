class ExpenseModel {
  ExpenseModel({
    required this.id,
    this.value = 0,
    this.paid = true,
    this.description = '',
    this.paymentDate,
  });

  String id;
  double value;
  bool paid;
  String? description;
  DateTime? paymentDate;
}
