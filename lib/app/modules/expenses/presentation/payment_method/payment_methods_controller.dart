import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entity/payment_type_detail_entity.dart';
import '../../domain/entity/payment_type_entity.dart';
import '../../domain/repository/payment_type_repository.dart';

part 'payment_methods_controller.g.dart';

class PaymentMethodsController = _PaymentMethodsController
    with _$PaymentMethodsController;

abstract class _PaymentMethodsController with Store {
  _PaymentMethodsController(this.repository);

  final PaymentMethodRepository repository;

  @observable
  ObservableList<PaymentTypeDetailEntity> paymentMethodsList = ObservableList();

  final TextEditingController inputPaymentTextController =
      TextEditingController();

  @observable
  String? inputPaymentMethodError;

  @observable
  bool isAdd = false;

  @observable
  bool isEdit = false;

  @observable
  PaymentTypeEntity? editingPaymentMethod;

  setInputPaymentMethodError(value) => inputPaymentMethodError = value;

  loadPaymentMethods() async {
    var paymentMethods = await repository.findAllWithCount();
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
  prepareForEdit(PaymentTypeEntity paymentMethod) {
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
          final model = PaymentTypeEntity(
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

  deletePaymentMethod(PaymentTypeEntity paymentMethod) async {
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
