import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myself_flutter/app/core/commons/formatters/date_formatter.dart';
import 'package:myself_flutter/app/core/commons/mask_util.dart';
import 'package:myself_flutter/app/core/theme/color_schemes.g.dart';

import 'save_expense_controller.dart';

class SaveExpensePage extends StatefulWidget {
  const SaveExpensePage(
      {super.key, required this.controller, required this.expenseId});

  final SaveExpenseController controller;
  final String? expenseId;

  @override
  State<SaveExpensePage> createState() => _SaveExpensePageState();
}

class _SaveExpensePageState extends State<SaveExpensePage> {
  @override
  void initState() {
    widget.controller.editExpense(widget.expenseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Observer(
            builder: (_) =>
                Text(widget.controller.editing ? 'Editar' : 'Despesa'),
          ),
        ),
        body: SingleChildScrollView(
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
                    border: Border.all(color: MyselfTheme.outlineColor),
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      'Preencha os campos:',
                      style: TextStyle(
                          color: MyselfTheme.colorPrimary, fontSize: 16),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: widget.controller.dateTimeTextController,
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2100),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDatePickerMode: DatePickerMode.day,
                        );
                        widget.controller.dateTimeTextController.text =
                            date!.format();
                      },
                      canRequestFocus: false,
                      keyboardType: TextInputType.none,
                      decoration: const InputDecoration(
                        labelText: 'Quando ?',
                        icon: Icon(Icons.calendar_month),
                      ),
                    ),
                    TextField(
                      controller: widget.controller.descriptionTextController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        icon: Icon(Icons.text_snippet),
                      ),
                    ),
                    TextField(
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
                        Switch(
                          value: widget.controller.paid,
                          onChanged: (checked) {
                            setState(() {
                              widget.controller.paid = checked;
                            });
                          },
                        ),
                      ],
                    ),
                    Observer(
                      builder: (_) => Text(
                        widget.controller.errorMessage ?? '',
                        style: TextStyle(
                          color: MyselfTheme.errorColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: widget.controller.saveExpense,
          label: const Text('Salvar'),
          icon: const Icon(Icons.done_rounded),
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
}
