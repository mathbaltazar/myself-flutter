import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/payment_method/model/detailed_payment_method_model.dart';

import '../../domain/model/payment_method_model.dart';
import '../../domain/repository/payment_method_repository.dart';

part 'payment_methods_controller.g.dart';

class PaymentMethodsController = _PaymentMethodsController
    with _$PaymentMethodsController;

abstract class _PaymentMethodsController with Store {
  _PaymentMethodsController(this.repository);

  final PaymentMethodRepository repository;

  @observable
  ObservableList<PaymentMethodModel> paymentMethodsList = ObservableList();

  final TextEditingController inputPaymentTextController =
      TextEditingController();

  @observable
  String? inputPaymentMethodError;

  @observable
  bool isAdd = false;

  @observable
  bool isEdit = false;

  @observable
  DetailedPaymentMethodModel? detailedPaymentMethodModel;

  @observable
  PaymentMethodModel? editingPaymentMethod;

  setInputPaymentMethodError(value) => inputPaymentMethodError = value;

  @action
  setSelectedPaymentMethod(PaymentMethodModel? value) {
    if (value != null) {
      var detailed = DetailedPaymentMethodModel();
      detailed.paymentMethod = value;
      // todo
      //detailed.currentMonthExpenseCount = expenseRepository.countByPaymentMethodByYearMonth(value, DateTime.now());
      //detailed.currentMonthExpenseCount = expenseRepository.countByPaymentMethod(value);
      detailedPaymentMethodModel = detailed;
    } else {
      detailedPaymentMethodModel = null;
    }
  }

  loadPaymentMethods() async {
    var paymentMethods = await repository.findAll();
    paymentMethodsList.clear();
    paymentMethodsList.addAll(paymentMethods);

    if (detailedPaymentMethodModel != null) {
      PaymentMethodModel? selected = paymentMethods.where((element) =>
          element.id == detailedPaymentMethodModel!.paymentMethod!.id).firstOrNull;

      setSelectedPaymentMethod(selected);
    }
  }

  @action
  prepareForInsert() {
    isAdd = true;
    isEdit = false;
    inputPaymentTextController.clear();
  }

  @action
  prepareForEdit(PaymentMethodModel paymentMethod) {
    isAdd = false;
    isEdit = true;
    editingPaymentMethod = paymentMethod;
    inputPaymentTextController.text = paymentMethod.name;
  }

  @action
  void cancelSave() {
    isAdd = false;
    isEdit = false;
    editingPaymentMethod = null;
  }

  void savePaymentMethod() {
    if (inputPaymentTextController.text.isEmpty) {
      setInputPaymentMethodError('Campo vazio');
    } else if (isAdd) {
      final model = PaymentMethodModel(
        name: inputPaymentTextController.text.trim(),
      );

      repository.save(model);

      cancelSave();
      loadPaymentMethods();
    } else if (isEdit) {
      if (editingPaymentMethod != null) {
        editingPaymentMethod!.name = inputPaymentTextController.text.trim();

        repository.save(editingPaymentMethod!);

        cancelSave();
        loadPaymentMethods();
      }
    }
  }

  deletePaymentMethod(PaymentMethodModel paymentMethod) async {
    repository.deleteById(paymentMethod.id!);
    loadPaymentMethods();
  }
}
