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
          label: Text(controller.editingPaymentType?.let((it) => 'Editar - ${it.name}') ?? 'Novo tipo de pagamento'),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton.filledTonal(
                  onPressed: controller.onPaymentTypeInputConfirmClick,
                  icon: const FaIcon(FontAwesomeIcons.check)),
              IconButton.filledTonal(
                  onPressed: controller.onPaymentTypeInputCancelClick,
                  icon: const FaIcon(FontAwesomeIcons.xmark)),
            ],
          )),
    );
  }
}
