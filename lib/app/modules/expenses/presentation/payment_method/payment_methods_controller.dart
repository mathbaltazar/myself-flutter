import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../domain/model/detailed_payment_method_model.dart';
import '../../domain/model/payment_method_model.dart';
import '../../domain/repository/payment_method_repository.dart';

part 'payment_methods_controller.g.dart';

class PaymentMethodsController = _PaymentMethodsController
    with _$PaymentMethodsController;

abstract class _PaymentMethodsController with Store {
  _PaymentMethodsController(this.repository);

  final PaymentMethodRepository repository;

  @observable
  ObservableList<DetailedPaymentMethodModel> paymentMethodsList = ObservableList();

  final TextEditingController inputPaymentTextController =
      TextEditingController();

  @observable
  String? inputPaymentMethodError;

  @observable
  bool isAdd = false;

  @observable
  bool isEdit = false;

  @observable
  PaymentMethodModel? editingPaymentMethod;

  setInputPaymentMethodError(value) => inputPaymentMethodError = value;

  loadPaymentMethods() async {
    var paymentMethods = await repository.findAllDetailed();
    paymentMethodsList.clear();
    paymentMethodsList.addAll(paymentMethods);
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
    inputPaymentMethodError = null;
    editingPaymentMethod = null;
  }

  void savePaymentMethod() {
    _validatePaymentMethodInput()
        .then((validated) {
      if (validated) {
        if (isAdd) {
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
    });
  }

  deletePaymentMethod(PaymentMethodModel paymentMethod) async {
    repository.deleteById(paymentMethod.id!);
    loadPaymentMethods();
  }

  Future<bool> _validatePaymentMethodInput() async {
    if (inputPaymentTextController.text.isEmpty) {
      setInputPaymentMethodError('Campo vazio');
    } else if (await repository.existsByName(inputPaymentTextController.text)) {
      setInputPaymentMethodError('Este método já existe');
    } else {
      setInputPaymentMethodError(null);
    }
    return inputPaymentMethodError == null;
  }
}
