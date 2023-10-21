import 'package:flutter/material.dart';
import 'package:myself_flutter/app/core/theme/color_schemes.g.dart';
import 'package:myself_flutter/app/core/utils/formatters/currency_formatter.dart';
import 'package:myself_flutter/app/core/utils/formatters/date_formatter.dart';
import 'package:myself_flutter/app/modules/expenses/domain/model/expense_model.dart';

class ExpenseItemDetails extends StatelessWidget {
  const ExpenseItemDetails({
    super.key,
    required this.expense,
    required this.onEdit,
    required this.onDelete,
    required this.onMarkAsPaid,
  });

  final ExpenseModel expense;
  final void Function() onEdit;
  final void Function() onDelete;
  final void Function() onMarkAsPaid;

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
                        fontSize: 16, color: MyselfTheme.colorPrimary)),
              ),
              IconButton.outlined(
                onPressed: onEdit,
                icon: const Icon(Icons.edit),
              ),
              IconButton.outlined(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_forever,
                  color: MyselfTheme.errorColor,
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
