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
              Watch.builder(builder: (_) => IconButton.filledTonal(
                  icon: FaIcon(
                    FontAwesomeIcons.checkDouble,
                    color: controller.selectedExpense.get()!.paid
                      ? null
                      : Theme.of(context).colorScheme.primary,
                  ),
                  tooltip: 'Marcar como pago',
                  onPressed: controller.selectedExpense.get()!.paid
                      ? null
                      : controller
                          .onExpenseDetailsMarkAsPaidButtonClicked,
                      )),
              IconButton.filled(
                icon: const FaIcon(FontAwesomeIcons.pen),
                onPressed: controller.onExpenseDetailsEditButtonClicked,
              ),
              IconButton.filled(
                icon: const FaIcon(FontAwesomeIcons.trashCan),
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Theme.of(context).colorScheme.error)),
                onPressed: () => _showDeleteConfirmation(context),
              ),
              MenuAnchor(
                menuChildren: [
                  MenuItemButton(
                    child: const Text('Tipo de pagamento...'),
                    onPressed: () => PaymentSelectDialog(
                      onSelect: (selected) {
                        controller.onExpenseDetailsPaymentTypeSelected(selected);
                        Modular.to.pop();
                      },
                    ).showAdaptive(context),
                  )
                ],
                builder: (_, menuController, __) => Watch.builder(
                    builder: (_) => IconButton.filledTonal(
                          icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
                          onPressed: !controller.selectedExpense.get()!.paid
                              ? null
                              : () => menuController.isOpen
                                  ? menuController.close()
                                  : menuController.open(),
                        )),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Watch.builder(
            builder: (_) => Text(controller.selectedExpense.get()!.description,
                  style: const TextStyle(fontSize: 16))
          ),
          const SizedBox(height: 8),
          Watch.builder(
            builder: (_) => Text(
                controller.selectedExpense.get()!.paymentDate.format(),
                style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.70),
                    ),
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
              const SizedBox(width: 10),
              Watch.builder(builder: (_) => Text(
                        controller.selectedExpense.get()!.paymentType?.name ??
                            'Não definido.',
                        style: TextStyle(
                          fontStyle:
                              controller.selectedExpense.get()!.paymentType == null
                                  ? FontStyle.italic
                                  : null,
                        ),
                      )),
            ],
          ),
        ],
      ),
    );
  }

  _showDeleteConfirmation(BuildContext context) {
    ConfirmationAlertDialog(
      title: 'Excluir a despesa ?',
      confirmLabel: 'Excluir',
      confirmLabelTextStyle: TextStyle(color: Theme.of(context).colorScheme.error),
      onCancel: Modular.to.pop,
      onConfirm: controller.onExpenseDetailsDeleteConfirmationButtonClicked,
    ).showAdaptive(context);
  }
}
