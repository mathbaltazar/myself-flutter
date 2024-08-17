import 'package:myselff/app/core/services/message_service.dart';
import 'package:myselff/app/modules/expenses/domain/entity/payment_type_entity.dart';
import 'package:myselff/app/modules/expenses/domain/usecase/payment_type_use_cases.dart';
import 'package:signals/signals.dart';

class PaymentTypeSelectDialogController {
  PaymentTypeSelectDialogController(this.paymentTypeUseCases);

  final PaymentTypeUseCases paymentTypeUseCases;

  final paymentTypeList = listSignal<PaymentTypeEntity>([PaymentTypeEntity.none()]);

  getPaymentTypes() async {
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
