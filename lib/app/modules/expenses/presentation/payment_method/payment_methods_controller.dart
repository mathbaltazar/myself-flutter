import 'package:mobx/mobx.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/model/payment_method_model.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/repository/payment_method_repository.dart';

part 'payment_methods_controller.g.dart';

class PaymentMethodsController = _PaymentMethodsController
    with _$PaymentMethodsController;

abstract class _PaymentMethodsController with Store {
  _PaymentMethodsController(this.repository);

  @observable
  ObservableList<PaymentMethodModel> paymentMethodsList = ObservableList();

  final PaymentMethodRepository repository;

  void loadPaymentMethods() async {
    var paymentMethods = await repository.findAll();
    paymentMethodsList.clear();
    paymentMethodsList.addAll(paymentMethods);
  }
}
