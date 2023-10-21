import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:myselff_flutter/app/core/services/message_service.dart';
import 'package:myselff_flutter/app/core/utils/domain_utils.dart';
import 'package:myselff_flutter/app/core/utils/formatters/currency_formatter.dart';
import 'package:myselff_flutter/app/core/utils/formatters/date_formatter.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/model/expense_model.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/repository/expenses_repository.dart';

part 'save_expense_controller.g.dart';

class SaveExpenseController = _SaveExpenseController
    with _$SaveExpenseController;

abstract class _SaveExpenseController with Store {
  _SaveExpenseController(this.repository);

  final ExpensesRepository repository;

  final TextEditingController descriptionTextController =
      TextEditingController();
  final TextEditingController valueTextController =
      TextEditingController(text: 0.0.formatCurrency());
  final TextEditingController dateTimeTextController =
      TextEditingController(text: DateTime.now().format());

  @observable
  String? editingId;

  @computed
  bool get editing => editingId != null;

  @observable
  String? descriptionError;

  @observable
  String? amountError;

  DateTime date = DateTime.now();

  @observable
  bool paid = false;

  @action
  setEditingId(value) => editingId = value;

  @action
  setDescriptionError(String? value) => descriptionError = value;

  @action
  setAmountError(String? value) => amountError = value;

  @action
  setPaid(bool value) => paid = value;

  setDate(value) {
    if (value != null) {
      date = value;
      dateTimeTextController.text = date.format();
    }
  }

  void editExpense(String? id) async {
    if (id != null) {
      // loading ?
      setEditingId(id);
      ExpenseModel? expenseModel = await repository.findById(id);
      if (expenseModel != null) {
        descriptionTextController.text = expenseModel.description;
        valueTextController.text = expenseModel.amount.formatCurrency();
        dateTimeTextController.text = expenseModel.paymentDate.format();
        paid = expenseModel.paid;
      }
    }
  }

  void saveExpense() {
    validateForm();
    var hasError =
        [descriptionError, amountError].any((error) => error != null);

    if (!hasError) {
      final expense = ExpenseModel(
        id: editingId ?? DomainUtils.nextId(),
        description: descriptionTextController.text.trim(),
        paymentDate: date,
        amount: valueTextController.text.parseCurrency(),
        paid: paid,
      );

      repository.save(expense);

      MessageService.showMessage('Despesa salva!');
      Modular.to.pop(true);
    }
  }

  void validateForm() {
    setDescriptionError(descriptionTextController.text.trim().isEmpty
        ? 'Preencha a descrição'
        : null);
    setAmountError(valueTextController.text.parseCurrency() <= 0
        ? 'O valor deve ser maior que zero'
        : null);
  }
}
