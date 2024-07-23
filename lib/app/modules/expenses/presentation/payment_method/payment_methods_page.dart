import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/presentation/widgets/confirmation_alert_dialog.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';

import '../../domain/model/payment_method_model.dart';
import 'payment_methods_controller.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key, required this.controller});

  final PaymentMethodsController controller;

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        /* If "0", removes shadowing after any body scroll physics */
        title: const Text('Gerenciar'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Observer(
                builder: (_) =>
                    widget.controller.isAdd || widget.controller.isEdit
                        ? TextField(
                            autofocus: true,
                            controller:
                                widget.controller.inputPaymentTextController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(widget.controller.isEdit
                                    ? Icons.credit_card
                                    : Icons.add_card),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton.filledTonal(
                                        onPressed:
                                            widget.controller.savePaymentMethod,
                                        icon: const Icon(Icons.check)),
                                    IconButton.filledTonal(
                                        onPressed: widget.controller.cancelSave,
                                        icon: const Icon(Icons.cancel)),
                                  ],
                                ),
                                label: Text(widget.controller.isEdit
                                    ? 'Editar'
                                    : 'Novo método'),
                                errorText:
                                    widget.controller.inputPaymentMethodError),
                          )
                        : Row(
                            children: [
                              const Icon(Icons.credit_card),
                              const SizedBox(width: 8),
                              const Text('Métodos de pagamento'),
                              const Spacer(),
                              TextButton.icon(
                                  icon: const Icon(Icons.add),
                                  onPressed: widget.controller.prepareForInsert,
                                  label: const Text('Adicionar')),
                            ],
                          ),
              ),
              const Divider(),
              Expanded(
                child: Observer(
                  builder: (_) => widget.controller.paymentMethodsList.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Center(
                              child: Text('Não há métodos para listar.')),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              widget.controller.paymentMethodsList.length,
                          itemBuilder: (ctx, index) {
                            final detailedPayment =
                                widget.controller.paymentMethodsList[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  detailedPayment.paymentMethod.name,
                                  overflow: TextOverflow.fade,
                                ),
                                subtitle: Text(
                                    'Total de despesas: ${detailedPayment.expenseCount}\nNeste mês: ${detailedPayment.currentMonthExpenseCount}'),
                                subtitleTextStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => widget.controller
                                          .prepareForEdit(
                                              detailedPayment.paymentMethod),
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () => _showDeleteConfirmation(
                                          ctx, detailedPayment.paymentMethod),
                                      icon: const Icon(Icons.delete_rounded),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDeleteConfirmation(
      BuildContext context, PaymentMethodModel paymentMethod) {
    showAdaptiveDialog(
      context: context,
      builder: (_) => ConfirmationAlertDialog(
          icon: const Icon(Icons.delete_rounded),
          title: 'Excluir o método de pagamento ?',
          onCancel: Modular.to.pop,
          confirmLabel: 'Excluir',
          confirmLabelTextStyle: TextStyle(color: MyselffTheme.errorColor),
          onConfirm: () {
            widget.controller.deletePaymentMethod(paymentMethod);
            Modular.to.pop();
          }),
    );
  }
}
