import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:myselff_flutter/app/core/extensions/object_extensions.dart';
import 'package:myselff_flutter/app/core/services/message_service.dart';

import '../../domain/entity/payment_type_detail_entity.dart';
import '../../domain/entity/payment_type_entity.dart';
import '../../domain/usecase/payment_type_use_cases.dart';

part 'payment_types_controller.g.dart';

class PaymentTypesController = _PaymentTypesController
    with _$PaymentTypesController;

abstract class _PaymentTypesController with Store {
  _PaymentTypesController(this.paymentTypeUseCases);

  final PaymentTypeUseCases paymentTypeUseCases;

  @observable
  ObservableList<PaymentTypeDetailEntity> paymentTypesList = ObservableList();
  @action
  setPaymentTypeList(ObservableList<PaymentTypeDetailEntity> value) =>
      paymentTypesList = value;

  final TextEditingController paymentTypeInputTextController = TextEditingController();

  @observable
  bool showPaymentTypeInput = false;

  @observable
  PaymentTypeEntity? editingPaymentType;

  @action
  onAddNewPaymentTypeClick() {
    showPaymentTypeInput = true;
    paymentTypeInputTextController.clear();
  }

  @action
  onEditPaymentTypeClick(PaymentTypeEntity paymentTypeEntity) {
    showPaymentTypeInput = true;
    editingPaymentType = paymentTypeEntity;
    paymentTypeInputTextController.text = paymentTypeEntity.name;
  }

  @action
  onPaymentTypeInputCancelClick() {
    showPaymentTypeInput = false;
    editingPaymentType = null;
  }

  onPaymentTypeInputConfirmClick() async {
    try {
      // Obtain the entity with id in case of a editing, otherwise create a new entity
      final paymentTypeEntity = editingPaymentType != null
          ? editingPaymentType!.also((it) => it.name = paymentTypeInputTextController.text.trim())
          : PaymentTypeEntity.withName(paymentTypeInputTextController.text.trim());

      // call to save the payment type entity use case
      // if error, shows a error message
      // if successful, retrieve all payments with its datasource id
      final result = await paymentTypeUseCases.savePaymentType(paymentTypeEntity: paymentTypeEntity);
      result.fold(
        (error) => MessageService.showErrorMessage(error.message),
        (success) {
          MessageService.showMessage('Tipo de pagamento salvo!');
          getPaymentTypes(); // maybe return the updated one?
          onPaymentTypeInputCancelClick();
        },
      );
    } on Exception {
      rethrow;
    }
  }

  onDeleteConfirmationClick(PaymentTypeEntity paymentTypeEntity) async {
    try {
      // call to delete payment type use case
      // if error, shows a error message
      // if delete successful, remove the payment type from state object list
      final result = await paymentTypeUseCases.deletePaymentType(
          paymentTypeId: paymentTypeEntity.id!);
      result.fold(
        (error) => MessageService.showErrorMessage('Erro ao excluir a tipo de pagamento'),
        (success) {
          paymentTypesList.removeWhere((e) => e.paymentType == paymentTypeEntity);
          MessageService.showMessage('Tipo de pagamento excluído!');
        },
      );
    } on Exception {
      rethrow;
    }
  }

  getPaymentTypes() async {
    try {
      // call to retrieve the list of payment types
      // if error, shows a error message
      // if successful, set the result to entity state object list
      final result = await paymentTypeUseCases.getPaymentTypesDetailed();
      result.fold(
        (error) => MessageService.showErrorMessage('Erro ao buscar os tipos de pagamento'),
        (items) => setPaymentTypeList(ObservableList.of(items)),
      );
    } on Exception {
      rethrow;
    }
  }
}
