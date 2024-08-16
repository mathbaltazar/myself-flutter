import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myselff_flutter/app/core/components/buttons/link_button.dart';
import 'package:myselff_flutter/app/core/utils/mask_util.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/entity/payment_type_entity.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/controllers/save_expense_controller.dart';
import 'package:signals/signals_flutter.dart';

class SaveExpensePage extends StatefulWidget {
  const SaveExpensePage(
      {super.key, required this.controller, this.expenseId});

  final SaveExpenseController controller;
  final int? expenseId;

  @override
  State<SaveExpensePage> createState() => _SaveExpensePageState();
}

class _SaveExpensePageState extends State<SaveExpensePage> {
  @override
  void initState() {
    widget.controller.init(widget.expenseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.controller.isEdit ? 'Editar' : 'Despesa'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 25),
            const Center(
              child: FaIcon(
                FontAwesomeIcons.clipboardList,
                size: 100,
              ),
            ),
            const SizedBox(height: 25),
            Card.outlined(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      'Preencha os campos:',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary, fontSize: 16),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: widget.controller.dateTimeTextController,
                      readOnly: true,
                      keyboardType: TextInputType.none,
                      onTap: _showDatePickDialog,
                      decoration: const InputDecoration(
                        labelText: 'Quando ?',
                        icon: FaIcon(FontAwesomeIcons.calendarCheck),
                      ),
                    ),
                    TextFormField(
                      controller: widget.controller.descriptionTextController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        icon: FaIcon(FontAwesomeIcons.alignJustify),
                      ),
                    ),
                    TextFormField(
                      controller: widget.controller.valueTextController,
                      inputFormatters: [MaskUtil.currency()],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Valor',
                        icon: FaIcon(FontAwesomeIcons.dollarSign),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.check),
                        const SizedBox(width: 15),
                        const Text('Está pago?'),
                        const Spacer(),
                        Watch.builder(
                          builder: (_) => Switch(
                              value: widget.controller.paid.get(),
                              onChanged: widget.controller.paid.set,
                            )
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.solidCreditCard),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Watch.builder(
                            builder: (_) => DropdownMenu<PaymentTypeEntity>(
                              enabled: widget.controller.paid.get(),
                              initialSelection: widget.controller.selectedPaymentType.get() ??
                                  widget.controller.paymentTypesList.first,
                              onSelected: widget.controller.selectedPaymentType.set,
                              label: const Text('Tipo de pagamento'),
                              textStyle: TextStyle(
                                color: widget.controller.paid.get() ? null : Colors.black26
                              ),
                              expandedInsets: EdgeInsets.zero,
                              inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                              dropdownMenuEntries: widget.controller.paymentTypesList
                                  .map((paymentType) => DropdownMenuEntry(
                                        value: paymentType,
                                        label: paymentType.name,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: LinkButton(
                        onClick: widget.controller.onManagePaymentTypesLinkClicked,
                        label: 'gerenciar métodos de pagamento',
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FilledButton.icon(
                onPressed: widget.controller.onSaveButtonClicked,
                label: const Text('Salvar'),
                icon: const FaIcon(FontAwesomeIcons.check),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dateTimeTextController.dispose();
    widget.controller.valueTextController.dispose();
    widget.controller.descriptionTextController.dispose();
    super.dispose();
  }

  _showDatePickDialog() async {
    final date = await showDatePicker(
      context: context,
      initialDate: widget.controller.date,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.day,
    );
    widget.controller.setDate(date);
  }
}
