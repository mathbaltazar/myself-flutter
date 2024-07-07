import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:myselff_flutter/app/core/routes/app_routes.dart';
import 'package:myselff_flutter/app/core/services/message_service.dart';
import 'package:myselff_flutter/app/core/utils/formatters/currency_formatter.dart';
import 'package:myselff_flutter/app/core/utils/formatters/date_formatter.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/model/expense_model.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/model/payment_method_model.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/repository/expenses_repository.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/repository/payment_method_repository.dart';

part 'save_expense_controller.g.dart';

class SaveExpenseController = _SaveExpenseController
    with _$SaveExpenseController;

abstract class _SaveExpenseController with Store {
  _SaveExpenseController(this.repository, this.paymentMethodRepository);

  final ExpensesRepository repository;
  final PaymentMethodRepository paymentMethodRepository;

  final TextEditingController descriptionTextController =
      TextEditingController();
  final TextEditingController valueTextController =
      TextEditingController(text: 0.0.formatCurrency());
  final TextEditingController dateTimeTextController =
      TextEditingController(text: DateTime.now().format());

  int? editingId;

  bool get isEdit => editingId != null;

  @observable
  String? descriptionError;

  @observable
  String? amountError;

  DateTime date = DateTime.now();

  @observable
  bool paid = false;

  @observable
  List<PaymentMethodModel> paymentMethods = [PaymentMethodModel.none()];

  @observable
  PaymentMethodModel? paymentMethodSelected;

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

  @action
  setPaymentMethod(PaymentMethodModel? selected) => paymentMethodSelected = selected;

  init(int? editExpenseId) async {
    await _loadPaymentMethods();
    await editExpense(editExpenseId);
  }

  @action
  _loadPaymentMethods() async {
    paymentMethods = await paymentMethodRepository.findAll();
    paymentMethods.insert(0, PaymentMethodModel.none());
  }

  editExpense(int? id) async {
    if (id != null) {
      setEditingId(id);
      ExpenseModel? expenseModel = await repository.findById(id);
      if (expenseModel != null) {
        descriptionTextController.text = expenseModel.description;
        valueTextController.text = expenseModel.amount.formatCurrency();
        dateTimeTextController.text = expenseModel.paymentDate.format();
        paid = expenseModel.paid;

        setPaymentMethod(paymentMethods
            .where((element) => element.id == expenseModel.paymentMethodId)
            .firstOrNull);
      }
    }
  }

  managePaymentMethod() async {
    await Modular.to.pushNamed(AppRoutes.expenseRoute + AppRoutes.paymentMethods);
    await _loadPaymentMethods();

    setPaymentMethod(paymentMethods
        .where((element) => element.id == paymentMethodSelected?.id)
        .firstOrNull);
  }

  void saveExpense() {
    validateForm();
    final hasError =
        [descriptionError, amountError].any((error) => error != null);

    if (!hasError) {
      final expense = ExpenseModel(
        id: editingId,
        description: descriptionTextController.text.trim(),
        paymentDate: date,
        amount: valueTextController.text.parseCurrency(),
        paid: paid,
        paymentMethodId: paid ? paymentMethodSelected?.id : null
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
