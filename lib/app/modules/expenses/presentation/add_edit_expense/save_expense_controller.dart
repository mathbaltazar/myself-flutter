import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:myself_flutter/app/core/commons/formatters/date_formatter.dart';
import 'package:myself_flutter/app/modules/expenses/domain/model/expense_model.dart';
import 'package:myself_flutter/app/modules/expenses/domain/repository/expenses_repository.dart';

part 'save_expense_controller.g.dart';

class SaveExpenseController = _SaveExpenseController with _$SaveExpenseController;

abstract class _SaveExpenseController with Store {

  final ExpensesRepository? repository = null; // TODO inject

  final TextEditingController descriptionTextController = TextEditingController(text: '');
  final TextEditingController valueTextController = TextEditingController(text: '\$ 0.00');
  final TextEditingController dateTimeTextController = TextEditingController(text: DateTime.now().format());

  @observable
  String? errorMessage;
  @action
  setErrorMessage(value) => errorMessage = value;

  @observable
  bool editing = false;
  @action
  setEditing(bool value) => editing = value;

  @observable
  bool paid = true;

  void editExpense(String? id) {
    if (id != null) {
      // loading ?
      ExpenseModel expenseModel = ExpenseModel(
          id: id); // todo repository.findById(id);
      descriptionTextController.text = expenseModel.description!;
      valueTextController.text = expenseModel.value.toStringAsFixed(2);
      dateTimeTextController.text = expenseModel.paymentDate?.format() ?? '';
      paid = expenseModel.paid;

      setEditing(false);
    }
  }

  void saveExpense() {
    var tudoOK = Random().nextBool();
    if (tudoOK) {
      // todo MessageService.showMessage(null, 'Despesa salva!');
      setErrorMessage('Tudo certo!');
      Modular.to.pop();
    } else {
      setErrorMessage('Erro qualquer');
    }
  }
}