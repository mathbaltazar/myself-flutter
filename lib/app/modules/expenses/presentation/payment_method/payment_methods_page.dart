import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/presentation/components/confirmation_alert_dialog.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';
import 'package:myselff_flutter/app/core/utils/formatters/date_formatter.dart';
import 'package:myselff_flutter/app/core/utils/media_query_utils.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/model/payment_method_model.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Métodos de pagamento'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 14, top: 14),
                child: Text('Listagem',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 15),
              Card(
                margin: const EdgeInsets.all(10),
                child: SizedBox(
                  height: MediaQueryUtils.height(context, percent: .32),
                  child: Observer(
                    builder: (_) =>
                    widget.controller.paymentMethodsList.isEmpty
                        ? const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Center(child: Text('Não há métodos para listar.')),
                        )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shrinkWrap: true,
                            itemCount:
                                widget.controller.paymentMethodsList.length,
                            itemBuilder: (ctx, index) {
                              final paymentMethod =
                                  widget.controller.paymentMethodsList[index];
                              return Row(
                                children: [
                                  Observer(
                                    builder: (_) => Visibility(
                                      visible: paymentMethod.name ==
                                          widget
                                              .controller
                                              .detailedPaymentMethodModel
                                              ?.paymentMethod
                                              ?.name,
                                      child: Icon(Icons.chevron_right,
                                          color: MyselffTheme.colorPrimary),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(paymentMethod.name,
                                          overflow: TextOverflow.fade),
                                      onTap: () {
                                        widget.controller
                                            .setSelectedPaymentMethod(
                                                paymentMethod);
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => widget.controller
                                        .prepareForEdit(paymentMethod),
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () => _showDeleteConfirmation(
                                        ctx, paymentMethod),
                                    icon: const Icon(Icons.delete_rounded),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (_, __) =>
                                const Divider(height: .5),
                          ),
                  ),
                ),
              ),
              Center(
                child: Observer(
                  builder: (_) => widget.controller.isAdd ||
                          widget.controller.isEdit
                      ? ListTile(
                          title: TextField(
                            controller:
                                widget.controller.inputPaymentTextController,
                            decoration: InputDecoration(
                                label: Text(widget.controller.isEdit
                                    ? 'Editar'
                                    : 'Novo método'),
                                icon: Icon(widget.controller.isEdit
                                    ? Icons.add_card_rounded
                                    : Icons.credit_card_rounded),
                                errorText:
                                    widget.controller.inputPaymentMethodError),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton.filledTonal(
                                  onPressed: widget.controller.savePaymentMethod,
                                  icon: const Icon(Icons.check)),
                              IconButton.filledTonal(
                                  onPressed: widget.controller.cancelSave,
                                  icon: const Icon(Icons.cancel)),
                            ],
                          ),
                        )
                      : TextButton.icon(
                          icon: const Icon(Icons.add_card),
                          onPressed: widget.controller.prepareForInsert,
                          label: const Text('Adicionar')),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 14, top: 14),
                child: Text('Detalhes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: MyselffTheme.colorPrimary.withAlpha(20),
                ),
                child: Observer(
                  builder: (_) =>
                      widget.controller.detailedPaymentMethodModel == null
                          ? const Text(
                              'Nenhum método selecionado',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                    widget.controller.detailedPaymentMethodModel
                                            ?.paymentMethod?.name ??
                                        '',
                                    style: TextStyle(
                                      color: MyselffTheme.colorPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    )),
                                const SizedBox(height: 18),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text:
                                          'Despesas neste mês (${DateTime.now().formatYearMonth()}):\n'),
                                  TextSpan(
                                      text:
                                          '${widget.controller.detailedPaymentMethodModel?.currentMonthExpenseCount}',
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic))
                                ])),
                                Text.rich(TextSpan(children: [
                                  const TextSpan(text: 'Todas as despesas:\n'),
                                  TextSpan(
                                      text:
                                          '${widget.controller.detailedPaymentMethodModel?.expenseCount}',
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic))
                                ])),
                                const SizedBox(height: 15),
                                OutlinedButton(
                                    onPressed: () {
                                      // todo ver despesas
                                    },
                                    child: const Text('Ver despesas'))
                              ],
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
