import 'package:flutter/material.dart';

import '../../domain/model/payment_method_model.dart';

class PaymentSelectDialog extends StatelessWidget {
  const PaymentSelectDialog({
    super.key,
    required this.paymentMethods,
    required this.onSelect,
  });

  final List<PaymentMethodModel> paymentMethods;
  final Function(PaymentMethodModel?) onSelect;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      icon: const Icon(Icons.credit_card),
      title: const Text('Métodos de pagamento',
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Scrollbar(
          child: Container(
            width: double.maxFinite,
            constraints: BoxConstraints.loose(const Size.fromHeight(224)),
            child: ListView.separated(
              itemCount: paymentMethods.length,
              itemBuilder: (_, index) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.arrow_right),
                title: Text(paymentMethods[index].name),
                onTap: () => onSelect(paymentMethods[index]),
              ),
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
        ),
      ),
    );
  }
}
