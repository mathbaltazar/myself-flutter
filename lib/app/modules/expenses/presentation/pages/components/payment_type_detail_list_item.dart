part of '../payment_types_page.dart';

class _PaymentTypeDetailListItem extends StatelessWidget {
  const _PaymentTypeDetailListItem(this.controller, this.paymentDetailEntity);

  final PaymentTypesController controller;
  final PaymentTypeDetailEntity paymentDetailEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(paymentDetailEntity.paymentType.name,
          overflow: TextOverflow.fade,
        ),
        subtitle: Text('Total de despesas: ${paymentDetailEntity.expenseCount}\nNeste mês: ${paymentDetailEntity.currentMonthExpenseCount}'),
        subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => controller.onEditPaymentTypeClick(paymentDetailEntity.paymentType),
              icon: const FaIcon(FontAwesomeIcons.pen),
            ),
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.trashCan),
              onPressed: () => ConfirmationAlertDialog(
                  title: 'Excluir o tipo de pagamento ?',
                  onCancel: Modular.to.pop,
                  confirmLabel: 'Excluir',
                  confirmLabelTextStyle:
                      TextStyle(color: Theme.of(context).colorScheme.error),
                  onConfirm: () {
                    controller.onDeleteConfirmationClick(paymentDetailEntity.paymentType);
                    Modular.to.pop();
                  }).showAdaptive(context),
            )
          ],
        ),
      ),
    );
  }

}
