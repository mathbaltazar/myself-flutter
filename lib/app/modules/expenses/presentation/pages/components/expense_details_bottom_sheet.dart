part of '../expenses_list_page.dart';

class _ExpenseDetailsBottomSheet extends StatelessWidget with BottomSheetMixin {
  const _ExpenseDetailsBottomSheet({required this.controller});

  final ExpensesListController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
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
                      color: Theme.of(context).colorScheme.primary,
                    )),
              ),
              IconButton.filledTonal(
                onPressed: controller.onExpenseDetailsPaidToggleButtonClicked,
                icon: FaIcon(
                  FontAwesomeIcons.checkDouble,
                  color: Theme.of(context).colorScheme.primary,
                ),
                tooltip: 'Marcar como pago',
              ),
              IconButton.filled(
                onPressed: controller.onExpenseDetailsEditButtonClicked,
                icon: const FaIcon(FontAwesomeIcons.pen),
              ),
              IconButton.filled(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Theme.of(context).colorScheme.error)),
                onPressed: () => _showDeleteConfirmation(context),
                icon: const FaIcon(FontAwesomeIcons.trashCan),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Watch.builder(
            builder: (_) => Text(controller.selectedExpense.get()!.description,
                  style: const TextStyle(fontSize: 16))
          ),
          Watch.builder(
            builder: (_) => Text(
                controller.selectedExpense.get()!.paymentDate.format(),
                style: const TextStyle(color: Colors.black54),
              )
          ),
          const SizedBox(height: 10),
          Watch.builder(
            builder: (_) => Text(
                controller.selectedExpense.get()!.amount.formatCurrency(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
          ),
          const SizedBox(height: 16),
          Row(
                children: [
                  const FaIcon(FontAwesomeIcons.creditCard),
                  const SizedBox(width: 8),
                  Watch.builder(builder: (_) => Text(
                          controller.selectedExpense.get()!.paymentType?.name ??
                              'Não definido.',
                          style: TextStyle(
                            fontStyle:
                                controller.selectedExpense.get()!.paymentType == null
                                    ? FontStyle.italic
                                    : null,
                          ),
                        )
                  ),
                  const SizedBox(width: 10),
                  Watch.builder(builder: (_) => Visibility(
                          visible:
                              controller.selectedExpense.get()!.paymentType == null,
                          child: LinkButton(
                            onClick: () => showAdaptiveDialog(
                                  context: context,
                                  builder: (context) => PaymentSelectDialog(
                                        onSelect: (selected) {
                                          controller.onExpenseDetailsPaymentTypeSelected(selected);
                                          Modular.to.pop();
                                        },
                                      )),
                            label: 'selecionar',
                            enabled: controller.selectedExpense.get()!.paid,
                          ),
                        )
                  ),
                ],
              ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    ConfirmationAlertDialog(
      title: 'Excluir a despesa ?',
      confirmLabel: 'Excluir',
      confirmLabelTextStyle: TextStyle(color: Theme.of(context).colorScheme.error),
      onCancel: Modular.to.pop,
      onConfirm: controller.onExpenseDetailsDeleteConfirmationButtonClicked,
    ).showAdaptive(context);
  }
}
