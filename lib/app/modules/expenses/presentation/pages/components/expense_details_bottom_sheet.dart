part of '../expenses_list_page.dart';

class _ExpenseDetailsBottomSheet extends StatelessWidget with BottomSheetMixin {
  const _ExpenseDetailsBottomSheet({required this.controller});

  final ExpensesListController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: StatefulComponent(
        builder: (a, refresh) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Detalhes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: MyselffTheme.colorPrimary,
                      )),
                ),
                IconButton.filled(
                  onPressed: () async {
                    await controller.onExpenseDetailsEditButtonClicked();
                    refresh();
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton.filled(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MyselffTheme.colorError)),
                  onPressed: () => _showDeleteConfirmation(context),
                  icon: const Icon(
                    Icons.delete_forever,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(controller.selectedExpense!.description,
                style: const TextStyle(fontSize: 16)),
            Text(
              controller.selectedExpense!.paymentDate.format(),
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Text(
              controller.selectedExpense!.amount.formatCurrency(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),
            Row(
                  children: [
                    const Icon(Icons.credit_card),
                    const SizedBox(width: 8),
                    Text(
                        controller.selectedExpense!.paymentType?.name ??
                            'Não definido.',
                        style: TextStyle(
                          fontStyle:
                              controller.selectedExpense!.paymentType == null
                                  ? FontStyle.italic
                                  : null,
                        ),
                      ),
                    const SizedBox(width: 10),
                    Visibility(
                        visible:
                            controller.selectedExpense!.paymentType == null,
                        child: LinkButton(
                          onClick: () => showAdaptiveDialog(
                                context: context,
                                builder: (context) => PaymentSelectDialog(
                                      onSelect: (selected) {
                                        controller.onExpenseDetailsPaymentTypeSelected(selected);
                                        Modular.to.pop(selected);
                                        refresh();
                                      },
                                    )),
                          label: 'selecionar',
                          enabled: controller.selectedExpense!.paid,
                        ),
                      ),
                  ],
                ),
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
              onPressed: () async {
                await controller.onExpenseDetailsPaidToggleButtonClicked();
                refresh();
              },
              icon: const Icon(Icons.paid),
              label: Text(
                'Marcar como ${controller.selectedExpense!.paid ? 'não pago' : 'pago'}',
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    ConfirmationAlertDialog(
        icon: const Icon(Icons.delete_rounded),
        title: 'Excluir a despesa ?',
        confirmLabel: 'Excluir',
        confirmLabelTextStyle: TextStyle(color: MyselffTheme.colorError),
        onCancel: Modular.to.pop,
        onConfirm: () {
          controller.onExpenseDetailsDeleteConfirmationButtonClicked();
          Modular.to.pop();
        }).showAdaptive(context);
  }
}
