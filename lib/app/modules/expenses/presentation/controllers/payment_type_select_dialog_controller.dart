import 'package:mobx/mobx.dart';
import 'package:myselff_flutter/app/core/services/message_service.dart';

import '../../domain/entity/payment_type_entity.dart';
import '../../domain/usecase/payment_type_use_cases.dart';

class PaymentTypeSelectDialogController {
  PaymentTypeSelectDialogController(this.paymentTypeUseCases);

  final PaymentTypeUseCases paymentTypeUseCases;

  ObservableList<PaymentTypeEntity> paymentTypeList = ObservableList();

  void getPaymentTypes() async {
    try {
      final result = await paymentTypeUseCases.getPaymentTypes();
      result.fold(
        (error) => MessageService.showErrorMessage('Erro ao buscar os tipos de pagamento'),
        (items) => paymentTypeList.addAll(items),
      );
    } on Exception {
      rethrow;
    }
  }
}
