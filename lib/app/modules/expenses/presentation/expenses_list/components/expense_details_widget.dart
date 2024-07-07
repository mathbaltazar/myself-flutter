import 'package:flutter/material.dart';
import 'package:myselff_flutter/app/core/presentation/widgets/widgets/link_button.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';
import 'package:myselff_flutter/app/core/utils/formatters/currency_formatter.dart';
import 'package:myselff_flutter/app/core/utils/formatters/date_formatter.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/expenses_list/expenses_list_controller.dart';

import '../../../domain/model/expense_model.dart';
import '../../../domain/model/payment_method_model.dart';

class ExpenseDetailsWidget extends StatelessWidget {
  const ExpenseDetailsWidget({
    super.key,
    required this.controller,
    required this.expense,
    this.paymentMethod,
    required this.onEdit,
    required this.onDelete,
    required this.onMarkAsPaid,
    required this.onSelectPaymentMethod,
  });

  final ExpensesListController controller;
  final ExpenseModel expense;
  final PaymentMethodModel? paymentMethod;
  final void Function() onEdit;
  final void Function() onDelete;
  final void Function() onMarkAsPaid;
  final void Function() onSelectPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                      color: MyselffTheme.colorPrimary,
                    )),
              ),
              IconButton.filled(
                onPressed: onEdit,
                icon: const Icon(Icons.edit),
              ),
              IconButton.filled(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MyselffTheme.errorColor)),
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_forever,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(expense.description, style: const TextStyle(fontSize: 16)),
          Text(
            expense.paymentDate.format(),
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 10),
          Text(
            expense.amount.formatCurrency(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.credit_card),
              const SizedBox(width: 8),
              Text(
                paymentMethod?.name ?? 'Não definido.',
                style: TextStyle(
                  fontStyle: paymentMethod == null ? FontStyle.italic : null,
                ),
              ),
              const SizedBox(width: 10),
              Visibility(
                visible: paymentMethod == null,
                child: LinkButton(
                  onClick: onSelectPaymentMethod,
                  label: 'selecionar',
                  enabled: expense.paid,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton.tonalIcon(
            onPressed: onMarkAsPaid,
            icon: const Icon(Icons.paid),
            label: Text('Marcar como ${expense.paid ? 'não pago' : 'pago'}'),
          )
        ],
      ),
    );
  }
}
