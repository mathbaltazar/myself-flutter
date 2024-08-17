import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff/app/core/constants/route_constants.dart';
import 'package:myselff/app/core/extensions/object_extensions.dart';
import 'package:myselff/app/core/services/message_service.dart';
import 'package:myselff/app/core/utils/formatters/currency_formatter.dart';
import 'package:myselff/app/core/utils/formatters/date_formatter.dart';
import 'package:myselff/app/modules/expenses/domain/entity/expense_entity.dart';
import 'package:myselff/app/modules/expenses/domain/entity/payment_type_entity.dart';
import 'package:myselff/app/modules/expenses/domain/usecase/expense_use_cases.dart';
import 'package:myselff/app/modules/expenses/domain/usecase/payment_type_use_cases.dart';
import 'package:signals/signals.dart';

class SaveExpenseController {
  SaveExpenseController(this.expenseUseCases, this.paymentTypeUseCases);

  final ExpenseUseCases expenseUseCases;
  final PaymentTypeUseCases paymentTypeUseCases;

  final TextEditingController descriptionTextController = TextEditingController();
  final TextEditingController valueTextController = TextEditingController(text: 0.0.formatCurrency());
  final TextEditingController dateTimeTextController = TextEditingController(text: DateTime.now().format());

  int? editingId;

  bool get isEdit => editingId != null;

  DateTime date = DateTime.now();

  final paymentTypesList = listSignal([PaymentTypeEntity.none()]);
  final selectedPaymentType = signal<PaymentTypeEntity?>(null);
  final paid = signal(true);

  setEditingId(value) => editingId = value;

  setDate(value) {
    if (value != null) {
      date = value;
      dateTimeTextController.text = date.format();
    }
  }

  init(int? editExpenseId) async {
    await _loadPaymentTypes();
    await _loadExpenseData(editExpenseId);
  }

  _loadPaymentTypes() async {
    final result = await paymentTypeUseCases.getPaymentTypes();
    result.fold(
      (error) => MessageService.showErrorMessage(error.message),
      (items) => paymentTypesList.set([PaymentTypeEntity.none(), ...items]),
    );
  }

  _loadExpenseData(int? id) async {
    final result = await expenseUseCases.getById(expenseId: id);
    result.fold(
      (error) => MessageService.showErrorMessage(error.message),
      (success) => success?.let((expenseEntity) {
          setEditingId(id);
          descriptionTextController.text = expenseEntity.description;
          valueTextController.text = expenseEntity.amount.formatCurrency();
          setDate(expenseEntity.paymentDate);
          paid.set(expenseEntity.paid);

          selectedPaymentType.set(paymentTypesList
              .where((element) => element == expenseEntity.paymentType)
              .singleOrNull);
        }),
    );
  }

  onManagePaymentTypesLinkClicked() async {
    await Modular.to.pushNamed(RouteConstants.expenseRoute + RouteConstants.paymentTypeRoute);
    await _loadPaymentTypes();

    selectedPaymentType.set(paymentTypesList
        .where((element) => element.id == selectedPaymentType.get()?.id)
        .singleOrNull);
  }

  onSaveButtonClicked() async {
    try {
      final expenseEntity = ExpenseEntity(
          id: editingId,
          description: descriptionTextController.text.trim(),
          paymentDate: date,
          amount: valueTextController.text.parseCurrency(),
          paid: paid.get(),
          paymentType: selectedPaymentType.get());

      final result = await expenseUseCases.saveExpense(expenseEntity: expenseEntity);

      result.fold(
        (error) {
          MessageService.showErrorMessage(error.message);
          debugPrint(error.message);
        },
        (success) {
          MessageService.showMessage('Despesa salva!');
          Modular.to.pop();
        },
      );
    } on Exception {
      rethrow;
    }
  }
}
