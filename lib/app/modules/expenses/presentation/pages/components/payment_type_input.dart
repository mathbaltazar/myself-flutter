part of '../payment_types_page.dart';

class _PaymentTypeInput extends StatelessWidget {
  const _PaymentTypeInput(this.controller);

  final PaymentTypesController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller.paymentTypeInputTextController,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.add_card),
          label: const Text('Nome'),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton.filledTonal(
                  onPressed: controller.onPaymentTypeInputConfirmClick,
                  icon: const Icon(Icons.check)),
              IconButton.filledTonal(
                  onPressed: controller.onPaymentTypeInputCancelClick,
                  icon: const Icon(Icons.cancel)),
            ],
          )),
    );
  }
}
