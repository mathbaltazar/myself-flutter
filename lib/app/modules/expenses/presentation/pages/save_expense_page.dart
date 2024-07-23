import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myselff_flutter/app/core/components/buttons/link_button.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';
import 'package:myselff_flutter/app/core/utils/mask_util.dart';

import '../../domain/entity/payment_type_entity.dart';
import '../controllers/save_expense_controller.dart';

class SaveExpensePage extends StatefulWidget {
  const SaveExpensePage(
      {super.key, required this.controller, required this.expenseId});

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Icon(
                Icons.assignment_rounded,
                size: 128,
              ),
              const SizedBox(height: 25),
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: MyselffTheme.colorOutline),
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      'Preencha os campos:',
                      style: TextStyle(
                          color: MyselffTheme.colorPrimary, fontSize: 16),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: widget.controller.dateTimeTextController,
                      readOnly: true,
                      keyboardType: TextInputType.none,
                      onTap: _showDatePickDialog,
                      decoration: const InputDecoration(
                        labelText: 'Quando ?',
                        icon: Icon(Icons.calendar_month),
                      ),
                    ),
                    TextFormField(
                      controller: widget.controller.descriptionTextController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        icon: Icon(Icons.text_snippet),
                      ),
                    ),
                    TextFormField(
                      controller: widget.controller.valueTextController,
                      inputFormatters: [MaskUtil.currency()],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Valor',
                        icon: Icon(Icons.attach_money),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_outline_rounded),
                        const SizedBox(width: 15),
                        const Text('Está pago?'),
                        const Spacer(),
                        Observer(
                          builder: (_) => Switch(
                              value: widget.controller.paid,
                              onChanged: widget.controller.setPaid,
                            )
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.credit_card),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Observer(
                            builder: (_) => DropdownMenu<PaymentTypeEntity>(
                              enabled: widget.controller.paid,
                              initialSelection: widget.controller.selectedPaymentType ??
                                  widget.controller.paymentTypesList.first,
                              onSelected: widget.controller.setPaymentType,
                              label: const Text('Tipo de pagamento'),
                              textStyle: TextStyle(
                                color: widget.controller.paid ? null : Colors.black26
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: widget.controller.onSaveButtonClicked,
        label: const Text('Salvar'),
        icon: const Icon(Icons.done_rounded),
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
