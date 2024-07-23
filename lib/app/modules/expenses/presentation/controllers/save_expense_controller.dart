import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:myselff_flutter/app/core/constants/route_constants.dart';
import 'package:myselff_flutter/app/core/services/message_service.dart';
import 'package:myselff_flutter/app/core/utils/formatters/currency_formatter.dart';
import 'package:myselff_flutter/app/core/utils/formatters/date_formatter.dart';

import '../../domain/entity/expense_entity.dart';
import '../../domain/entity/payment_type_entity.dart';
import '../../domain/usecase/expense_use_cases.dart';
import '../../domain/usecase/payment_type_use_cases.dart';

part 'save_expense_controller.g.dart';

class SaveExpenseController = _SaveExpenseController
    with _$SaveExpenseController;

abstract class _SaveExpenseController with Store {
  _SaveExpenseController(this.expenseUseCases, this.paymentTypeUseCases);

  final ExpenseUseCases expenseUseCases;
  final PaymentTypeUseCases paymentTypeUseCases;

  final TextEditingController descriptionTextController =
      TextEditingController();
  final TextEditingController valueTextController =
      TextEditingController(text: 0.0.formatCurrency());
  final TextEditingController dateTimeTextController =
      TextEditingController(text: DateTime.now().format());

  int? editingId;

  bool get isEdit => editingId != null;

  DateTime date = DateTime.now();

  @observable
  bool paid = false;

  @observable
  List<PaymentTypeEntity> paymentTypesList = [PaymentTypeEntity.none()];

  @observable
  PaymentTypeEntity? selectedPaymentType;

  setEditingId(value) => editingId = value;

  @action
  setPaid(bool value) => paid = value;

  setDate(value) {
    if (value != null) {
      date = value;
      dateTimeTextController.text = date.format();
    }
  }

  @action
  setPaymentType(PaymentTypeEntity? selected) => selectedPaymentType = selected;

  init(int? editExpenseId) async {
    await _loadPaymentTypes();
    await _loadExpenseData(editExpenseId);
  }

  @action
  _loadPaymentTypes() async {
    final result = await paymentTypeUseCases.getPaymentTypes();
    result.fold(
      (error) => MessageService.showErrorMessage(error.message),
      (items) {
        paymentTypesList.clear();
        paymentTypesList.addAll([PaymentTypeEntity.none(), ...items]);
      },
    );
  }

  _loadExpenseData(int? id) async {
    final result = await expenseUseCases.getById(expenseId: id);
    result.fold(
      (error) => MessageService.showErrorMessage(error.message),
      (entity) {
        ExpenseEntity? expenseEntity = entity;
        if (expenseEntity != null) {
          setEditingId(id);
          descriptionTextController.text = expenseEntity.description;
          valueTextController.text = expenseEntity.amount.formatCurrency();
          setDate(expenseEntity.paymentDate);
          paid = expenseEntity.paid;

          setPaymentType(paymentTypesList
              .where((element) => element == expenseEntity.paymentType)
              .firstOrNull);
        }
      },
    );
  }

  onManagePaymentTypesLinkClicked() async {
    await Modular.to.pushNamed(RouteConstants.expenseRoute + RouteConstants.paymentTypeRoute);
    await _loadPaymentTypes();

    setPaymentType(paymentTypesList
        .where((element) => element.id == selectedPaymentType?.id)
        .singleOrNull);
  }

  onSaveButtonClicked() async {
    try {
      final expenseEntity = ExpenseEntity(
          id: editingId,
          description: descriptionTextController.text.trim(),
          paymentDate: date,
          amount: valueTextController.text.parseCurrency(),
          paid: paid,
          paymentType: paid ? selectedPaymentType : null);

      final result = await expenseUseCases.saveExpense(expenseEntity: expenseEntity);

      result.fold(
        (error) {
          MessageService.showErrorMessage(error.message);
          debugPrint(error.message);
        },
        (success) {
          MessageService.showMessage('Despesa salva!');
          Modular.to.pop(true);
        },
      );
    } on Exception {
      rethrow;
    }
  }
}
